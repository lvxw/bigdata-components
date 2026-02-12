FROM 10.10.52.13:5000/lakehouse/flink:1.20.3

ARG FLINK_VERSION="1.20.3"
ARG KYUUBI_VERSION="1.11.0"
ARG SPARK_MAIN_VERSION="3.5"
ARG SPARK_VERSION="${SPARK_MAIN_VERSION}.4"
ARG PAIMON_VERSION="1.3.1"
ARG GRAVITINO_VERSION="1.1.0"
ARG CELEBORN_VERSION="0.6.2"

RUN wget -P /usr/local/src/ https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop3.tgz && \
    tar zxvf /usr/local/src/spark-${SPARK_VERSION}-bin-hadoop3.tgz -C /usr/local/ && \
    rm -rf /usr/local/src/spark-${SPARK_VERSION}-bin-hadoop3.tgz && \
    wget -P /usr/local/src/ https://archive.apache.org/dist/kyuubi/kyuubi-${KYUUBI_VERSION}/apache-kyuubi-${KYUUBI_VERSION}-bin.tgz && \
    tar zxvf /usr/local/src/apache-kyuubi-${KYUUBI_VERSION}-bin.tgz -C /usr/local/ && \
    rm -rf /usr/local/src/apache-kyuubi-${KYUUBI_VERSION}-bin.tgz

COPY /dependency/spark-${SPARK_VERSION}/spark-defaults.conf /usr/local/spark-${SPARK_VERSION}-bin-hadoop3/conf/
COPY /dependency/kyuubi-${KYUUBI_VERSION}/kyuubi-env.sh /usr/local/apache-kyuubi-${KYUUBI_VERSION}-bin/conf
COPY /dependency/kyuubi-${KYUUBI_VERSION}/kyuubi-defaults.conf /usr/local/apache-kyuubi-${KYUUBI_VERSION}-bin/conf
COPY /dependency/kyuubi-${KYUUBI_VERSION}/sql-client-init-gravitino.sql /usr/local/flink-${FLINK_VERSION}/conf/

RUN wget -P /usr/local/spark-${SPARK_VERSION}-bin-hadoop3/jars/ https://repo.maven.apache.org/maven2/org/apache/paimon/paimon-spark-3.5/1.3.1/paimon-spark-3.5-1.3.1.jar && \
    wget -P /usr/local/spark-${SPARK_VERSION}-bin-hadoop3/jars/ https://repo.maven.apache.org/maven2/org/apache/gravitino/gravitino-spark-common/1.1.0/gravitino-spark-common-1.1.0.jar && \
    wget -P /usr/local/spark-${SPARK_VERSION}-bin-hadoop3/jars/ https://repo.maven.apache.org/maven2/org/apache/gravitino/gravitino-spark-connector-runtime-3.5_2.12/1.1.0/gravitino-spark-connector-runtime-3.5_2.12-1.1.0.jar && \
    wget -P /usr/local/spark-${SPARK_VERSION}-bin-hadoop3/jars/ https://repo.maven.apache.org/maven2/org/apache/celeborn/celeborn-client-spark-3-shaded_2.12/0.6.2/celeborn-client-spark-3-shaded_2.12-0.6.2.jar && \
    wget -P /usr/local/flink-${FLINK_VERSION}/lib/ https://repo.maven.apache.org/maven2/org/apache/gravitino/gravitino-flink-connector-runtime-1.18_2.12/1.1.0/gravitino-flink-connector-runtime-1.18_2.12-1.1.0.jar && \
    wget -P /usr/local/apache-kyuubi-${KYUUBI_VERSION}-bin/externals/engines/jdbc/ https://repo.maven.apache.org/maven2/mysql/mysql-connector-java/8.0.28/mysql-connector-java-8.0.28.jar && \
    cp /usr/local/apache-kyuubi-${KYUUBI_VERSION}-bin/externals/engines/jdbc/mysql-connector-java-8.0.28.jar /usr/local/apache-kyuubi-${KYUUBI_VERSION}-bin/jars/ && \
    cp /usr/local/apache-kyuubi-${KYUUBI_VERSION}-bin/externals/engines/jdbc/mysql-connector-java-8.0.28.jar /usr/local/spark-${SPARK_VERSION}-bin-hadoop3/jars/

RUN mv ${FLINK_HOME}/opt/flink-table-planner-loader-${FLINK_VERSION}.jar ${FLINK_HOME}/lib/  && \
    mv ${FLINK_HOME}/lib/flink-table-planner_2.12-${FLINK_VERSION}.jar ${FLINK_HOME}/opt/ && \
    cp ${HIVE_HOME}/conf/hive-site.xml /usr/local/spark-${SPARK_VERSION}-bin-hadoop3/conf/ && \
    echo "export KYUUBI_HOME=/usr/local/apache-kyuubi-${KYUUBI_VERSION}-bin" >> /etc/profile && \
    echo "export SPARK_HOME=/usr/local/spark-${SPARK_VERSION}-bin-hadoop3" >> /etc/profile && \
    echo 'export PATH=${PATH}:${SPARK_HOME}/bin' >> /etc/profile && \
    echo 'export PATH=${PATH}:${KYUUBI_HOME}/bin:${SPARK_HOME}/bin' >> /etc/profile && \
    rm -rf /usr/local/bin/enter-beeline.sh

ENV KYUUBI_HOME /usr/local/apache-kyuubi-${KYUUBI_VERSION}-bin
ENV SPARK_HOME /usr/local/spark-${SPARK_VERSION}-bin-hadoop3
ENV PATH ${PATH}:${SPARK_HOME}/bin
ENV PATH ${PATH}:${KYUUBI_HOME}/bin:${SPARK_HOME}/bin

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo ' ' >> /usr/local/bin/enterpoint.sh && \
    echo 'while [[ `echo -e '"'"'\\n'"'"' | telnet hadoop 8020 2>/dev/null | grep Connected | wc -l` -eq 0 ]]' >> /usr/local/bin/enterpoint.sh && \
    echo 'do' >> /usr/local/bin/enterpoint.sh && \
    echo '  nohup echo "check hadoop sleep ......" >> ${FLINK_HOME}/log/sleep.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo '  sleep 1s' >> /usr/local/bin/enterpoint.sh && \
    echo 'done' >> /usr/local/bin/enterpoint.sh && \
    echo ' ' >> /usr/local/bin/enterpoint.sh && \
    echo 'application_id=`yarn application -list  |  grep  kyuubi-flink-yarn-session   |  awk '"'"'{print $1}'"'"'`'  >> /usr/local/bin/enterpoint.sh && \
    echo 'if [[ ${application_id} != "" ]]'  >> /usr/local/bin/enterpoint.sh && \
    echo 'then'  >> /usr/local/bin/enterpoint.sh && \
    echo '  yarn application -kill  ${application_id}'  >> /usr/local/bin/enterpoint.sh && \
    echo 'fi'  >> /usr/local/bin/enterpoint.sh && \
    echo ' ' >> /usr/local/bin/enterpoint.sh && \
    echo 'hdfs dfs -mkdir -p /hive' >> /usr/local/bin/enterpoint.sh && \
    echo 'hdfs dfs -put -f ${HIVE_HOME}/conf /hive/' >> /usr/local/bin/enterpoint.sh && \
    echo 'hdfs dfs -chmod 777 /user' >> /usr/local/bin/enterpoint.sh && \
    echo 'sed -i '"'"'s#/usr/local/apache-hive-3.1.2-bin/conf#hdfs:///hive/conf#g'"'"' ${FLINK_HOME}/conf/sql-client-init.sql' >> /usr/local/bin/enterpoint.sh && \
    echo ' ' >> /usr/local/bin/enterpoint.sh && \
    echo 'echo "#!/bin/bash" > ${KYUUBI_HOME}/bin/kyuubi-flink.sh'  >> /usr/local/bin/enterpoint.sh && \
    echo 'echo "" >> ${KYUUBI_HOME}/bin/kyuubi-flink.sh'  >> /usr/local/bin/enterpoint.sh && \
    echo 'echo "${KYUUBI_HOME}/bin/beeline --incremental=true -n root -p root -u '"'"'jdbc:hive2://kyuubi:10009/;#kyuubi.engine.type=FLINK_SQL;flink.execution.target=yarn-application'"'"' -i ${FLINK_HOME}/conf/sql-client-init.sql" >> ${KYUUBI_HOME}/bin/kyuubi-flink.sh'  >> /usr/local/bin/enterpoint.sh && \
    echo 'chmod 755 ${KYUUBI_HOME}/bin/kyuubi-flink.sh' >> /usr/local/bin/enterpoint.sh && \
    echo ' ' >> /usr/local/bin/enterpoint.sh && \
    echo 'echo "#!/bin/bash" > ${KYUUBI_HOME}/bin/kyuubi-flink-gravitino.sh'  >> /usr/local/bin/enterpoint.sh && \
    echo 'echo "" >> ${KYUUBI_HOME}/bin/kyuubi-flink-gravitino.sh'  >> /usr/local/bin/enterpoint.sh && \
    echo 'echo "${KYUUBI_HOME}/bin/beeline --incremental=true -n root -p root -u '"'"'jdbc:hive2://kyuubi:10009/;#kyuubi.engine.type=FLINK_SQL;flink.execution.target=yarn-application;table.catalog-store.kind=gravitino;table.catalog-store.gravitino.gravitino.metalake=lakehouse_metalake;table.catalog-store.gravitino.gravitino.uri=http://gravitino:8090'"'"' -i ${FLINK_HOME}/conf/sql-client-init-gravitino.sql" >> ${KYUUBI_HOME}/bin/kyuubi-flink-gravitino.sh'  >> /usr/local/bin/enterpoint.sh && \
    echo 'chmod 755 ${KYUUBI_HOME}/bin/kyuubi-flink-gravitino.sh' >> /usr/local/bin/enterpoint.sh && \
    echo ' ' >> /usr/local/bin/enterpoint.sh && \
    echo 'echo "#!/bin/bash" > ${KYUUBI_HOME}/bin/kyuubi-spark.sh'  >> /usr/local/bin/enterpoint.sh && \
    echo 'echo "${KYUUBI_HOME}/bin/beeline --incremental=true -n root -p root -u '"'"'jdbc:hive2://kyuubi:10009/;#kyuubi.engine.type=SPARK_SQL;spark.master=yarn;spark.sql.catalog.paimon_catalog=org.apache.paimon.spark.SparkCatalog;spark.sql.catalog.paimon_catalog.warehouse=hdfs://hadoop:8020/warehouse/tablespace/managed/hive;spark.sql.extensions=org.apache.paimon.spark.extensions.PaimonSparkSessionExtensions'"'"'" >> ${KYUUBI_HOME}/bin/kyuubi-spark.sh'  >> /usr/local/bin/enterpoint.sh && \
    echo 'chmod 755 ${KYUUBI_HOME}/bin/kyuubi-spark.sh' >> /usr/local/bin/enterpoint.sh && \
    echo ' ' >> /usr/local/bin/enterpoint.sh && \
    echo 'echo "#!/bin/bash" > ${KYUUBI_HOME}/bin/kyuubi-spark-gravitino.sh'  >> /usr/local/bin/enterpoint.sh && \
    echo 'echo "${KYUUBI_HOME}/bin/beeline --incremental=true -n root -p root -u '"'"'jdbc:hive2://kyuubi:10009/;#kyuubi.engine.type=SPARK_SQL;spark.master=yarn;spark.plugins=org.apache.gravitino.spark.connector.plugin.GravitinoSparkPlugin;spark.sql.gravitino.uri=http://gravitino:8090;spark.sql.gravitino.metalake=lakehouse_metalake;spark.sql.gravitino.enablePaimonSupport=true;spark.sql.gravitino.client.socketTimeoutMs=60000;spark.sql.gravitino.client.connectionTimeoutMs=60000;spark.sql.warehouse.dir=hdfs://hadoop:8020/warehouse/tablespace/managed/hive'"'"'" >> ${KYUUBI_HOME}/bin/kyuubi-spark-gravitino.sh'  >> /usr/local/bin/enterpoint.sh && \
    echo 'chmod 755 ${KYUUBI_HOME}/bin/kyuubi-spark-gravitino.sh' >> /usr/local/bin/enterpoint.sh && \
    echo ' ' >> /usr/local/bin/enterpoint.sh && \
    echo 'echo "#!/bin/bash" > ${KYUUBI_HOME}/bin/kyuubi-hive.sh'  >> /usr/local/bin/enterpoint.sh && \
    echo 'echo "${KYUUBI_HOME}/bin/beeline --incremental=true -n root -p root -u '"'"'jdbc:hive2://kyuubi:10009/;#kyuubi.engine.type=HIVE_SQL;kyuubi.engine.hive.deploy.mode=yarn'"'"'" >> ${KYUUBI_HOME}/bin/kyuubi-hive.sh'  >> /usr/local/bin/enterpoint.sh && \
    echo 'chmod 755 ${KYUUBI_HOME}/bin/kyuubi-hive.sh' >> /usr/local/bin/enterpoint.sh && \
    echo ' ' >> /usr/local/bin/enterpoint.sh && \
    echo 'echo "#!/bin/bash" > ${KYUUBI_HOME}/bin/kyuubi-trino.sh'  >> /usr/local/bin/enterpoint.sh && \
    echo 'echo "${KYUUBI_HOME}/bin/beeline --incremental=true -n root -p root -u '"'"'jdbc:hive2://kyuubi:10009/;#kyuubi.engine.type=TRINO;kyuubi.session.engine.trino.connection.url=http://trino:8087;kyuubi.session.engine.trino.connection.catalog=paimon'"'"'" >> ${KYUUBI_HOME}/bin/kyuubi-trino.sh'  >> /usr/local/bin/enterpoint.sh && \
    echo 'chmod 755 ${KYUUBI_HOME}/bin/kyuubi-trino.sh' >> /usr/local/bin/enterpoint.sh && \
    echo ' ' >> /usr/local/bin/enterpoint.sh && \
    echo 'echo "#!/bin/bash" > ${KYUUBI_HOME}/bin/kyuubi-doris.sh'  >> /usr/local/bin/enterpoint.sh && \
    echo 'echo "${KYUUBI_HOME}/bin/beeline --incremental=true -n root -p root -u '"'"'jdbc:hive2://kyuubi:10009/;#kyuubi.engine.jdbc.connection.url=jdbc:mysql://doris:49030/test;kyuubi.engine.jdbc.connection.user=doris;kyuubi.engine.jdbc.connection.password=doris;kyuubi.engine.jdbc.type=doris;kyuubi.engine.jdbc.driver.class=com.mysql.cj.jdbc.Driver;kyuubi.engine.type=jdbc'"'"'" >> ${KYUUBI_HOME}/bin/kyuubi-doris.sh'  >> /usr/local/bin/enterpoint.sh && \
    echo 'chmod 755 ${KYUUBI_HOME}/bin/kyuubi-doris.sh' >> /usr/local/bin/enterpoint.sh && \
    echo ' ' >> /usr/local/bin/enterpoint.sh && \
    echo 'echo "#!/bin/bash" > ${KYUUBI_HOME}/bin/kyuubi-mysql.sh'  >> /usr/local/bin/enterpoint.sh && \
    echo 'echo "${KYUUBI_HOME}/bin/beeline --incremental=true -n root -p root -u '"'"'jdbc:hive2://kyuubi:10009/;#kyuubi.engine.jdbc.connection.url=jdbc:mysql://mysql:3306/test;kyuubi.engine.jdbc.connection.user=root;kyuubi.engine.jdbc.connection.password=root;kyuubi.engine.jdbc.type=mysql;kyuubi.engine.jdbc.driver.class=com.mysql.cj.jdbc.Driver;kyuubi.engine.type=jdbc'"'"'" >> ${KYUUBI_HOME}/bin/kyuubi-mysql.sh'  >> /usr/local/bin/enterpoint.sh && \
    echo 'chmod 755 ${KYUUBI_HOME}/bin/kyuubi-mysql.sh' >> /usr/local/bin/enterpoint.sh && \
    echo ' ' >> /usr/local/bin/enterpoint.sh && \
    echo 'kyuubi start' >> /usr/local/bin/enterpoint.sh && \
    echo 'sleep infinity' >> /usr/local/bin/enterpoint.sh

# Kyuubi Flink yarn-session模式
#RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
#    echo ' ' >> /usr/local/bin/enterpoint.sh && \
#    echo 'while [[ `echo -e '"'"'\\n'"'"' | telnet hadoop 8020 2>/dev/null | grep Connected | wc -l` -eq 0 ]]' >> /usr/local/bin/enterpoint.sh && \
#    echo 'do' >> /usr/local/bin/enterpoint.sh && \
#    echo '  nohup echo "check hadoop sleep ......" >> ${FLINK_HOME}/log/sleep.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
#    echo '  sleep 1s' >> /usr/local/bin/enterpoint.sh && \
#    echo 'done' >> /usr/local/bin/enterpoint.sh && \
#    echo ' ' >> /usr/local/bin/enterpoint.sh && \
#        echo 'yarn-session.sh -nm kyuubi-flink-yarn-session -d'  >> /usr/local/bin/enterpoint.sh && \
#        echo 'application_id=`yarn application -list  |  grep  kyuubi-flink-yarn-session   |  awk '"'"'{print $1}'"'"'`'  >> /usr/local/bin/enterpoint.sh && \
#        echo 'echo "#!/bin/bash" > ${KYUUBI_HOME}/bin/kyuubi-flink.sh'  >> /usr/local/bin/enterpoint.sh && \
#        echo 'echo "" >> ${KYUUBI_HOME}/bin/kyuubi-flink.sh'  >> /usr/local/bin/enterpoint.sh && \
#        echo 'echo "CREATE CATALOG paimon_catalog WITH ('"'"'type'"'"' = '"'"'paimon'"'"', '"'"'table.type'"'"' = '"'"'external'"'"', '"'"'metastore'"'"' = '"'"'hive'"'"', '"'"'uri'"'"' = '"'"'thrift://hive:9083'"'"', '"'"'warehouse'"'"' = '"'"'hdfs:///warehouse/tablespace/external/hive/'"'"');" >> ${FLINK_HOME}/conf/sql-client-init.sql ' >> /usr/local/bin/enterpoint.sh && \
#        echo 'echo "beeline --incremental=true -n root -p root -u '"'"'jdbc:hive2://kyuubi:10009/;#kyuubi.engine.type=FLINK_SQL;execution.target=yarn-session;kyuubi.session.engine.flink.max.rows=1000000;yarn.application.id=${application_id}'"'"' -i ${FLINK_HOME}/conf/sql-client-init.sql" >> ${KYUUBI_HOME}/bin/kyuubi-flink.sh'  >> /usr/local/bin/enterpoint.sh && \
#        echo 'chmod 755 ${KYUUBI_HOME}/bin/kyuubi-flink.sh' >> /usr/local/bin/enterpoint.sh && \
#    echo ' ' >> /usr/local/bin/enterpoint.sh && \
#    echo 'chmod 755 ${KYUUBI_HOME}/bin/kyuubi-flink.sh' >> /usr/local/bin/enterpoint.sh && \
#    echo 'kyuubi start' >> /usr/local/bin/enterpoint.sh && \
#    echo 'tail -f /root/.bashrc' >> /usr/local/bin/enterpoint.sh \
