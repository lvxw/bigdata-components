FROM 10.10.52.13:5000/lakehouse/hive:3.1.3

ARG FLINK_MAIN_VERSION="1.20"
ARG FLINK_VERSION="${FLINK_MAIN_VERSION}.3"
ARG PAIMON_VERSION="1.3.1"
ARG ICEBERG_VERSION="1.10.1"
ARG FLUSS_VERSION="0.9.0-incubating"
ARG CELEBORN_VERSION="0.6.2"

RUN wget -P /usr/local/src/ https://archive.apache.org/dist/flink/flink-${FLINK_VERSION}/flink-${FLINK_VERSION}-bin-scala_2.12.tgz && \
    tar zxvf /usr/local/src/flink-${FLINK_VERSION}-bin-scala_2.12.tgz -C /usr/local/ && \
    rm -rf /usr/local/src/flink-${FLINK_VERSION}-bin-scala_2.12.tgz

RUN wget -P /usr/local/flink-${FLINK_VERSION}/lib/ https://repo.maven.apache.org/maven2/org/apache/flink/flink-table-api-java-uber/${FLINK_VERSION}/flink-table-api-java-uber-${FLINK_VERSION}.jar && \
    wget -P /usr/local/flink-${FLINK_VERSION}/lib/ https://repo.maven.apache.org/maven2/org/apache/flink/flink-table-api-scala-bridge_2.12/${FLINK_VERSION}/flink-table-api-scala-bridge_2.12-${FLINK_VERSION}.jar && \
    wget -P /usr/local/flink-${FLINK_VERSION}/lib/ https://repo.maven.apache.org/maven2/org/apache/flink/flink-sql-connector-hive-3.1.3_2.12/${FLINK_VERSION}/flink-sql-connector-hive-3.1.3_2.12-${FLINK_VERSION}.jar && \
    wget -P /usr/local/flink-${FLINK_VERSION}/lib/ https://repo.maven.apache.org/maven2/org/apache/flink/flink-sql-connector-kafka/3.4.0-${FLINK_MAIN_VERSION}/flink-sql-connector-kafka-3.4.0-${FLINK_MAIN_VERSION}.jar && \
    wget -P /usr/local/flink-${FLINK_VERSION}/lib/ https://repo.maven.apache.org/maven2/org/apache/flink/flink-connector-jdbc/3.3.0-${FLINK_MAIN_VERSION}/flink-connector-jdbc-3.3.0-${FLINK_MAIN_VERSION}.jar && \
    wget -P /usr/local/flink-${FLINK_VERSION}/lib/ https://repo.maven.apache.org/maven2/mysql/mysql-connector-java/8.0.28/mysql-connector-java-8.0.28.jar && \
    wget -P /usr/local/flink-${FLINK_VERSION}/lib/ https://repo.maven.apache.org/maven2/org/apache/flink/flink-metrics-dropwizard/${FLINK_VERSION}/flink-metrics-dropwizard-${FLINK_VERSION}.jar && \
    wget -P /usr/local/flink-${FLINK_VERSION}/lib/ https://repo.maven.apache.org/maven2/org/apache/doris/flink-doris-connector-${FLINK_MAIN_VERSION}/25.1.0/flink-doris-connector-${FLINK_MAIN_VERSION}-25.1.0.jar && \
    wget -P /usr/local/flink-${FLINK_VERSION}/lib/ https://repo.maven.apache.org/maven2/org/apache/flink/flink-orc/${FLINK_VERSION}/flink-orc-${FLINK_VERSION}.jar && \
    wget -P /usr/local/flink-${FLINK_VERSION}/lib/ https://repo.maven.apache.org/maven2/org/apache/orc/orc-core/1.5.6/orc-core-1.5.6.jar && \
    wget -P /usr/local/flink-${FLINK_VERSION}/lib/ https://repo.maven.apache.org/maven2/org/apache/orc/orc-shims/1.5.6/orc-shims-1.5.6.jar && \
    wget -P /usr/local/flink-${FLINK_VERSION}/lib/ https://repo.maven.apache.org/maven2/org/apache/flink/flink-sql-connector-mysql-cdc/3.5.0/flink-sql-connector-mysql-cdc-3.5.0.jar && \
    wget -P /usr/local/flink-${FLINK_VERSION}/lib/ https://repo.maven.apache.org/maven2/org/apache/paimon/paimon-flink-${FLINK_MAIN_VERSION}/${PAIMON_VERSION}/paimon-flink-${FLINK_MAIN_VERSION}-${PAIMON_VERSION}.jar && \
    wget -P /usr/local/flink-${FLINK_VERSION}/lib/ https://repo.maven.apache.org/maven2/org/apache/paimon/paimon-flink-action/${PAIMON_VERSION}/paimon-flink-action-${PAIMON_VERSION}.jar && \
    wget -P /usr/local/flink-${FLINK_VERSION}/lib/ https://repo.maven.apache.org/maven2/org/apache/paimon/paimon-s3/${PAIMON_VERSION}/paimon-s3-${PAIMON_VERSION}.jar && \
    wget -P /usr/local/flink-${FLINK_VERSION}/lib/ https://repo.maven.apache.org/maven2/org/apache/fluss/fluss-flink-${FLINK_MAIN_VERSION}/${FLUSS_VERSION}/fluss-flink-${FLINK_MAIN_VERSION}-${FLUSS_VERSION}.jar && \
    wget -P /usr/local/flink-${FLINK_VERSION}/lib/ https://repo.maven.apache.org/maven2/org/apache/fluss/fluss-flink-tiering/${FLUSS_VERSION}/fluss-flink-tiering-${FLUSS_VERSION}.jar && \
    wget -P /usr/local/flink-${FLINK_VERSION}/lib/ https://repo.maven.apache.org/maven2/org/apache/fluss/fluss-fs-hdfs/${FLUSS_VERSION}/fluss-fs-hdfs-${FLUSS_VERSION}.jar && \
    wget -P /usr/local/flink-${FLINK_VERSION}/lib/ https://repo.maven.apache.org/maven2/org/apache/celeborn/celeborn-client-flink-${FLINK_MAIN_VERSION}-shaded_2.12/${CELEBORN_VERSION}/celeborn-client-flink-${FLINK_MAIN_VERSION}-shaded_2.12-${CELEBORN_VERSION}.jar && \
    wget -P /usr/local/flink-${FLINK_VERSION}/lib/ https://repo.maven.apache.org/maven2/org/apache/fluss/fluss-lake-paimon/${FLUSS_VERSION}/fluss-lake-paimon-${FLUSS_VERSION}.jar && \
    wget -P /usr/local/bin/ https://dl.min.io/client/mc/release/linux-amd64/mc && \
    wget -P /usr/local/flink-${FLINK_VERSION}/lib/ https://repo1.maven.org/maven2/software/amazon/awssdk/bundle/2.35.4/bundle-2.35.4.jar && \
    wget -P /usr/local/flink-${FLINK_VERSION}/lib/ https://repo.maven.apache.org/maven2/org/apache/iceberg/iceberg-flink-runtime-1.20/${ICEBERG_VERSION}/iceberg-flink-runtime-1.20-${ICEBERG_VERSION}.jar

COPY /dependency/flink-${FLINK_VERSION}/flink-connector-jdbc-3.3.0-${FLINK_MAIN_VERSION}-meta-service  /META-INF/services/org.apache.flink.table.factories.Factory
COPY /dependency/flink-${FLINK_VERSION}/config.yaml /usr/local/flink-${FLINK_VERSION}/conf/
COPY /dependency/flink-${FLINK_VERSION}/enter-sql-client.sh /usr/local/bin/
COPY /dependency/flink-${FLINK_VERSION}/sql-client-init.sql /usr/local/flink-${FLINK_VERSION}/conf/

RUN cp /usr/local/hadoop-3.4.3/share/hadoop/client/hadoop-client-runtime-3.4.3.jar /usr/local/flink-${FLINK_VERSION}/lib/ && \
    cp /usr/local/hadoop-3.4.3/share/hadoop/client/hadoop-client-runtime-3.4.3.jar /usr/local/flink-${FLINK_VERSION}/lib/ && \
    cp /usr/local/hadoop-3.4.3/share/hadoop/client/hadoop-client-api-3.4.3.jar /usr/local/flink-${FLINK_VERSION}/lib/ && \
    cp /usr/local/hadoop-3.4.3/share/hadoop/hdfs/hadoop-hdfs-3.4.3.jar /usr/local/flink-${FLINK_VERSION}/lib/ && \
    cp /usr/local/hadoop-3.4.3/share/hadoop/mapreduce/hadoop-mapreduce-client-core-3.4.3.jar /usr/local/flink-${FLINK_VERSION}/lib/ && \
    cp /usr/local/hadoop-3.4.3/share/hadoop/common/hadoop-common-3.4.3.jar /usr/local/flink-${FLINK_VERSION}/lib/ && \
    zip -d /usr/local/flink-${FLINK_VERSION}/lib/flink-sql-connector-hive-3.1.3_2.12-${FLINK_VERSION}.jar org/apache/calcite/\* && \
    zip -d /usr/local/flink-${FLINK_VERSION}/lib/flink-sql-connector-hive-3.1.3_2.12-${FLINK_VERSION}.jar org/apache/orc/\* && \
    zip -u /usr/local/flink-${FLINK_VERSION}/lib/flink-connector-jdbc-3.3.0-${FLINK_MAIN_VERSION}.jar /META-INF/services/org.apache.flink.table.factories.Factory && \
    echo "export FLINK_HOME=/usr/local/flink-${FLINK_VERSION}" >> /etc/profile && \
    echo 'export PATH=${PATH}F:${FLINK_HOME}/bin' >> /etc/profile && \
    mv /usr/local/flink-${FLINK_VERSION}/lib/flink-table-planner-loader-${FLINK_VERSION}.jar   /usr/local/flink-${FLINK_VERSION}/opt/  && \
    mv /usr/local/flink-${FLINK_VERSION}/opt/flink-table-planner_2.12-${FLINK_VERSION}.jar /usr/local/flink-${FLINK_VERSION}/lib/ && \
    cp /usr/local/flink-${FLINK_VERSION}/opt/flink-sql-client-${FLINK_VERSION}.jar /usr/local/flink-${FLINK_VERSION}/lib/ && \
    cp /usr/local/flink-${FLINK_VERSION}/opt/flink-sql-gateway-${FLINK_VERSION}.jar /usr/local/flink-${FLINK_VERSION}/lib/ && \
    chmod 755 /usr/local/bin/mc && \
    chmod 755 /usr/local/bin/*.sh

ENV FLINK_HOME /usr/local/flink-${FLINK_VERSION}
ENV PATH ${PATH}:${FLINK_HOME}/bin

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo 'while [[ `echo -e '"'"'\\n'"'"' | telnet hadoop 8020 2>/dev/null | grep Connected | wc -l` -eq 0 ]]' >> /usr/local/bin/enterpoint.sh && \
    echo 'do' >> /usr/local/bin/enterpoint.sh && \
    echo '  nohup echo "check hadoop sleep ......" >> ${FLINK_HOME}/log/sleep.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo '  sleep 1s' >> /usr/local/bin/enterpoint.sh && \
    echo 'done' >> /usr/local/bin/enterpoint.sh && \
    echo 'while [[ `echo -e '"'"'\\n'"'"' | telnet fluss 9123 2>/dev/null | grep Connected | wc -l` -eq 0 ]]' >> /usr/local/bin/enterpoint.sh && \
    echo 'do' >> /usr/local/bin/enterpoint.sh && \
    echo '  nohup echo "check fluss sleep ......" >> ${FLINK_HOME}/log/sleep.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo '  sleep 1s' >> /usr/local/bin/enterpoint.sh && \
    echo 'done' >> /usr/local/bin/enterpoint.sh && \
    echo 'hdfs dfs -mkdir -p /flink/completed-jobs' >> /usr/local/bin/enterpoint.sh && \
    echo 'hdfs dfs -mkdir -p /hive/conf' >> /usr/local/bin/enterpoint.sh && \
    echo 'hdfs dfs -put -f ${HIVE_HOME}/conf/* /hive/conf/' >> /usr/local/bin/enterpoint.sh && \
    echo 'historyserver.sh start' >> /usr/local/bin/enterpoint.sh && \
    echo 'while [[ `echo -e '"'"'\\n'"'"' | telnet minio 9000 2>/dev/null | grep Connected | wc -l` -eq 0 ]]' >> /usr/local/bin/enterpoint.sh && \
    echo 'do' >> /usr/local/bin/enterpoint.sh && \
    echo '  nohup echo "check minio sleep ......" >> ${FLINK_HOME}/log/sleep.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo '  sleep 1s' >> /usr/local/bin/enterpoint.sh && \
    echo 'done' >> /usr/local/bin/enterpoint.sh && \
    echo 'mc alias set myminio http://minio:9000 admin admin123456 && mc mb --ignore-existing myminio/bigdata' >> /usr/local/bin/enterpoint.sh && \
    echo 'mysql -hmysql -uroot -proot -e "create database if not exists paimon_catalog;"' >> /usr/local/bin/enterpoint.sh && \
    echo ' ' >> /usr/local/bin/enterpoint.sh && \
    echo 'sql-gateway.sh start \' >> /usr/local/bin/enterpoint.sh && \
    echo '    -Dsql-gateway.endpoint.type=rest \' >> /usr/local/bin/enterpoint.sh && \
    echo '    -Dsql-gateway.endpoint.rest.address=flink \' >> /usr/local/bin/enterpoint.sh && \
    echo '    -Dsql-gateway.endpoint.rest.bind-address=flink \' >> /usr/local/bin/enterpoint.sh && \
    echo '    -Dsql-gateway.endpoint.rest.port=10004' >> /usr/local/bin/enterpoint.sh && \
    echo ' ' >> /usr/local/bin/enterpoint.sh && \
    echo 'nohup nc  -lk 9000 > /dev/null  2>&1  &' >> /usr/local/bin/enterpoint.sh && \
    echo ' ' >> /usr/local/bin/enterpoint.sh && \
    echo 'yarn application -list  |  grep  sep_SocketWindowWordCount | awk '"'"'{print $1}'"'"' |  xargs yarn application -kill' >> /usr/local/bin/enterpoint.sh && \
    echo 'flink run-application -p 2 -D pipeline.name sep_SocketWindowWordCount -D execution.checkpointing.interval 10s -D yarn.application.name sep_SocketWindowWordCount -t yarn-application -c org.apache.flink.streaming.examples.socket.SocketWindowWordCount ${FLINK_HOME}/examples/streaming/SocketWindowWordCount.jar --hostname flink --port 9000' >> /usr/local/bin/enterpoint.sh && \
    echo ' ' >> /usr/local/bin/enterpoint.sh && \
    echo 'sleep infinity' >> /usr/local/bin/enterpoint.sh && \
    dos2unix /usr/local/bin/*




