FROM 10.10.52.13:5000/lakehouse/flink:1.20.3

ARG GRAVITINO_VERSION="1.1.0"
ARG FLINK_MAIN_VERSION="1.20"
ARG FLINK_VERSION="${FLINK_MAIN_VERSION}.3"

RUN apt-get update && \
    apt-get --purge remove -y openjdk-8-jdk-headless openjdk-8-jdk openjdk-8-jre-headless openjdk-8-jre && \
    apt-get install -y openjdk-17-jdk && \
    apt-get clean

ENV JAVA_HOME /usr/lib/jvm/java-17-openjdk-amd64

RUN wget -P /usr/local/src/ https://archive.apache.org/dist/gravitino/${GRAVITINO_VERSION}/gravitino-${GRAVITINO_VERSION}-bin.tar.gz && \
    tar zxvf /usr/local/src/gravitino-${GRAVITINO_VERSION}-bin.tar.gz -C /usr/local/ && \
    rm -rf /usr/local/src/gravitino-${GRAVITINO_VERSION}-bin.tar.gz

RUN wget -P /usr/local/gravitino-${GRAVITINO_VERSION}-bin/catalogs/fileset/libs/ https://repo.maven.apache.org/maven2/org/apache/gravitino/gravitino-aws-bundle/${GRAVITINO_VERSION}/gravitino-aws-bundle-${GRAVITINO_VERSION}.jar && \
    wget -P /usr/local/gravitino-${GRAVITINO_VERSION}-bin/libs/ https://repo.maven.apache.org/maven2/mysql/mysql-connector-java/8.0.28/mysql-connector-java-8.0.28.jar && \
    wget -P /usr/local/flink-${FLINK_VERSION}/lib/ https://repo.maven.apache.org/maven2/org/apache/gravitino/gravitino-flink-connector-runtime-1.18_2.12/${GRAVITINO_VERSION}/gravitino-flink-connector-runtime-1.18_2.12-${GRAVITINO_VERSION}.jar && \
    wget -P ${HADOOP_HOME}/share/hadoop/common/lib/ https://repo.maven.apache.org/maven2/org/apache/gravitino/gravitino-filesystem-hadoop3-runtime/${GRAVITINO_VERSION}/gravitino-filesystem-hadoop3-runtime-${GRAVITINO_VERSION}.jar

COPY /dependency/gravitino-${GRAVITINO_VERSION}/enter-sql-client.sh /usr/local/bin/
COPY /dependency/gravitino-${GRAVITINO_VERSION}/sql-client-init.sql /usr/local/flink-${FLINK_VERSION}/conf/
COPY /dependency/gravitino-${GRAVITINO_VERSION}/core-site.xml ${HADOOP_HOME}/etc/hadoop/
COPY /dependency/gravitino-${GRAVITINO_VERSION}/gravitino.conf /usr/local/gravitino-${GRAVITINO_VERSION}-bin/conf/
COPY /dependency/gravitino-${GRAVITINO_VERSION}/init.sql /usr/local/gravitino-${GRAVITINO_VERSION}-bin/scripts/mysql/

RUN echo "export GRAVITINO_HOME=/usr/local/gravitino-${GRAVITINO_VERSION}-bin" >> /etc/profile && \
    echo 'export PATH=${PATH}:${GRAVITINO_HOME}/bin' >> /etc/profile && \
    sed -i 's/java-8-openjdk-amd64/java-17-openjdk-amd64/' /etc/profile && \
    rm -rf /usr/local/bin/enter-beeline.sh /usr/local/bin/mc && \
    rm -rf ${FLINK_HOME}/lib/fluss-*.jar && \
    echo '' >> ${FLINK_HOME}/conf/config.yaml && \
    echo 'table.catalog-store.kind: gravitino' >> ${FLINK_HOME}/conf/config.yaml && \
    echo 'table.catalog-store.gravitino.gravitino.metalake: lakehouse_metalake' >> ${FLINK_HOME}/conf/config.yaml && \
    echo 'table.catalog-store.gravitino.gravitino.uri: http://gravitino:8090' >> ${FLINK_HOME}/conf/config.yaml && \
    sed -i 's#FLINK_ENV_JAVA_OPTS="${FLINK_ENV_JAVA_OPTS} ${FLINK_ENV_JAVA_OPTS_CLI}"#FLINK_ENV_JAVA_OPTS="${FLINK_ENV_JAVA_OPTS} ${FLINK_ENV_JAVA_OPTS_CLI}  --add-exports java.base/sun.net.dns=ALL-UNNAMED"#' ${FLINK_HOME}/bin/yarn-session.sh && \
    sed -i 's#FLINK_ENV_JAVA_OPTS="${FLINK_ENV_JAVA_OPTS} ${FLINK_ENV_JAVA_OPTS_CLI}"#FLINK_ENV_JAVA_OPTS="${FLINK_ENV_JAVA_OPTS} ${FLINK_ENV_JAVA_OPTS_CLI}  --add-exports java.base/sun.net.dns=ALL-UNNAMED"#' ${FLINK_HOME}/bin/sql-client.sh && \
    echo 'export HADOOP_OPTS="$HADOOP_OPTS --add-exports=java.base/sun.net.dns=ALL-UNNAMED --add-exports=java.base/sun.net.util=ALL-UNNAMED"' >> ${HADOOP_HOME}/etc/hadoop/hadoop-env.sh

ENV GRAVITINO_HOME /usr/local/gravitino-${GRAVITINO_VERSION}-bin
ENV PATH ${PATH}:${GRAVITINO_HOME}/bin

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo 'mkdir -p ${GRAVITINO_HOME}/logs' && \
    echo 'source /etc/profile' >> /usr/local/bin/enterpoint.sh && \
    echo 'while [[ `echo -e '"'"'\\n'"'"' | telnet hadoop 8020 2>/dev/null | grep Connected | wc -l` -eq 0 ]]' >> /usr/local/bin/enterpoint.sh && \
    echo 'do' >> /usr/local/bin/enterpoint.sh && \
    echo '  nohup echo "check hadoop sleep ......" >> ${GRAVITINO_HOME}/logs/sleep.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo '  sleep 1s' >> /usr/local/bin/enterpoint.sh && \
    echo 'done' >> /usr/local/bin/enterpoint.sh && \
    echo 'yarn application -list | grep '"'"'RUNNING'"'"' | grep '"'"'gravitino-flink-session'"'"' | awk '"'"'{print $1}'"'"' | grep '"'"'application_'"'"' | xargs yarn application -kill' >> /usr/local/bin/enterpoint.sh && \
    echo 'yarn-session.sh -nm gravitino-flink-session -d' >> /usr/local/bin/enterpoint.sh && \
    echo 'while [[ `echo -e '"'"'\\n'"'"' | telnet mysql 3306 2>/dev/null | grep Connected | wc -l` -eq 0 ]]' >> /usr/local/bin/enterpoint.sh && \
    echo 'do' >> /usr/local/bin/enterpoint.sh && \
    echo '  nohup echo "check mysql sleep ......" >> ${GRAVITINO_HOME}/logs/sleeps.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo '  sleep 1s' >> /usr/local/bin/enterpoint.sh && \
    echo 'done' >> /usr/local/bin/enterpoint.sh && \
    echo 'mysql -hmysql -uroot -proot -e "drop database if exists gravitino;"' >> /usr/local/bin/enterpoint.sh && \
    echo 'mysql -hmysql -uroot -proot -e "create database if not exists gravitino;"' >> /usr/local/bin/enterpoint.sh && \
    echo "mysql -hmysql -uroot -proot -Dgravitino < ${GRAVITINO_HOME}/scripts/mysql/schema-${GRAVITINO_VERSION}-mysql.sql" >> /usr/local/bin/enterpoint.sh && \
    echo 'mysql -hmysql -uroot -proot -Dgravitino < ${GRAVITINO_HOME}/scripts/mysql/init.sql' >> /usr/local/bin/enterpoint.sh && \
    echo 'gravitino.sh start' >> /usr/local/bin/enterpoint.sh && \
    echo 'while [[ `echo -e '"'"'\\n'"'"' | telnet gravitino 8090 2>/dev/null | grep Connected | wc -l` -eq 0 ]]' >> /usr/local/bin/enterpoint.sh && \
    echo 'do' >> /usr/local/bin/enterpoint.sh && \
    echo '  nohup echo "check gravitino sleep ......" >> ${GRAVITINO_HOME}/logs/sleep.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo '  sleep 1s' >> /usr/local/bin/enterpoint.sh && \
    echo 'done' >> /usr/local/bin/enterpoint.sh && \
    echo 'curl -X POST -H "Accept: application/vnd.gravitino.v1+json" -H "Content-Type: application/json" -d '"'"'{"name":"hdfs_catalog","type":"FILESET","comment":"comment","properties":{"default-filesystem-provider":"builtin-hdfs","location":"hdfs://hadoop:8020/"}}'"'"' http://gravitino:8090/api/metalakes/lakehouse_metalake/catalogs' >> /usr/local/bin/enterpoint.sh && \
    echo 'hdfs dfs -rm -r hdfs://hadoop:8020/gravitino_test' >> /usr/local/bin/enterpoint.sh && \
    echo 'curl -X POST -H "Accept: application/vnd.gravitino.v1+json" -H "Content-Type: application/json" -d '"'"'{"name":"gravitino_test","comment":"comment","properties":{"location":"hdfs://hadoop:8020/gravitino_test"}}'"'"' http://gravitino:8090/api/metalakes/lakehouse_metalake/catalogs/hdfs_catalog/schemas' >> /usr/local/bin/enterpoint.sh && \
    echo 'curl -X POST -H "Accept: application/vnd.gravitino.v1+json" -H "Content-Type: application/json" -d '"'"'{"name":"example_fileset","comment":"This is an example fileset","type":"MANAGED","storageLocation":"hdfs://hadoop:8020/gravitino_test/example_fileset","properties":{"k1":"v1"}}'"'"' http://gravitino:8090/api/metalakes/lakehouse_metalake/catalogs/hdfs_catalog/schemas/gravitino_test/filesets' >> /usr/local/bin/enterpoint.sh && \
    echo 'hdfs dfs -put -f /bin/passwd gvfs://fileset/hdfs_catalog/gravitino_test/example_fileset/' >> /usr/local/bin/enterpoint.sh && \
    echo 'curl -X POST -H "Accept: application/vnd.gravitino.v1+json" -H "Content-Type: application/json" -d '"'"'{"name":"kafka_catalog","type":"MESSAGING","comment":"comment","provider":"kafka","properties":{"bootstrap.servers":"kafka:9092"}}'"'"' http://gravitino:8090/api/metalakes/lakehouse_metalake/catalogs' >> /usr/local/bin/enterpoint.sh && \
    echo 'curl -X POST -H "Accept: application/vnd.gravitino.v1+json" -H "Content-Type: application/json" -d '"'"'{"name":"example_topic","comment":"This is an example topic","properties":{"partition-count":"3","replication-factor":1}}'"'"' http://gravitino:8090/api/metalakes/lakehouse_metalake/catalogs/kafka_catalog/schemas/default/topics' >> /usr/local/bin/enterpoint.sh && \
    echo 'sleep infinity' >> /usr/local/bin/enterpoint.sh
