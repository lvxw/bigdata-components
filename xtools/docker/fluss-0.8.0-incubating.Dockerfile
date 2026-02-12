FROM 10.10.52.13:5000/lakehouse/flink:1.20.3

ARG FLINK_MAIN_VERSION="1.20"
ARG FLINK_VERSION="${FLINK_MAIN_VERSION}.3"
ARG FLUSS_VERSION="0.8.0-incubating"
ARG HIVE_VERSION="3.1.2"


RUN wget -P /usr/local/src/ https://archive.apache.org/dist/incubator/fluss/fluss-${FLUSS_VERSION}/fluss-${FLUSS_VERSION}-bin.tgz && \
    tar zxvf /usr/local/src/fluss-${FLUSS_VERSION}-bin.tgz -C /usr/local/ && \
    rm -rf /usr/local/src/fluss-${FLUSS_VERSION}-bin.tgz && \
    cp -r /usr/local/flink-${FLINK_VERSION}/lib/flink-sql-connector-hive-3.1.3_2.12-${FLINK_VERSION}.jar /usr/local/fluss-${FLUSS_VERSION}/plugins/paimon/

ADD /dependency/fluss-${FLUSS_VERSION}/server.yaml /usr/local/fluss-${FLUSS_VERSION}/conf/
COPY /dependency/fluss-${FLUSS_VERSION}/enter-sql-client.sh /usr/local/bin/
COPY /dependency/fluss-${FLUSS_VERSION}/sql-client-init.sql /usr/local/flink-${FLINK_VERSION}/conf/

RUN echo "export FLUSS_HOME=/usr/local/fluss-${FLUSS_VERSION}" >> /etc/profile && \
    echo 'export PATH=${PATH}:${FLUSS_HOME}/bin' >> /etc/profile && \
    chmod 755 /usr/local/fluss-${FLUSS_VERSION}/bin/local-cluster.sh && \
    chmod 755 /usr/local/bin/enter-sql-client.sh

ENV FLUSS_HOME /usr/local/fluss-${FLUSS_VERSION}
ENV PATH ${PATH}:${FLUSS_HOME}/bin

RUN rm -rf ${FLUSS_HOME}/plugins/paimon/flink-shaded-hadoop-2-uber-2.8.3-10.0.jar && \
    cp ${FLINK_HOME}/lib/flink-shaded-hadoop-3-uber-3.1.1.7.2.9.0-173-9.0.jar ${FLUSS_HOME}/plugins/paimon/ && \
    cp ${FLINK_HOME}/lib/flink-shaded-hadoop-3-uber-3.1.1.7.2.9.0-173-9.0.jar ${FLUSS_HOME}/lib/ && \
    rm -rf /usr/local/bin/enter-beeline.sh && \
    dos2unix /usr/local/fluss-${FLUSS_VERSION}/bin/*.sh && \
    chmod 755 /usr/local/fluss-${FLUSS_VERSION}/bin/*.sh


RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo 'mkdir -p ${FLUSS_HOME}/log' >> /usr/local/bin/enterpoint.sh && \
    echo 'while [[ `echo -e '"'"'\\n'"'"' | telnet hadoop 8020 2>/dev/null | grep Connected | wc -l` -eq 0 ]]' >> /usr/local/bin/enterpoint.sh && \
    echo 'do' >> /usr/local/bin/enterpoint.sh && \
    echo '  nohup echo "check hadoop sleep ......" >> ${FLUSS_HOME}/log/sleep.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo '  sleep 1s' >> /usr/local/bin/enterpoint.sh && \
    echo 'done' >> /usr/local/bin/enterpoint.sh && \
    echo 'while [[ `echo -e '"'"'\\n'"'"' | telnet hadoop 8088 2>/dev/null | grep Connected | wc -l` -eq 0 ]]' >> /usr/local/bin/enterpoint.sh && \
    echo 'do' >> /usr/local/bin/enterpoint.sh && \
    echo '  nohup echo "check hadoop sleep ......" >> ${FLUSS_HOME}/log/sleep.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo '  sleep 1s' >> /usr/local/bin/enterpoint.sh && \
    echo 'done' >> /usr/local/bin/enterpoint.sh && \
    echo 'while [[ `echo -e '"'"'\\n'"'"' | telnet zookeeper 2181 2>/dev/null | grep Connected | wc -l` -eq 0 ]]' >> /usr/local/bin/enterpoint.sh && \
    echo 'do' >> /usr/local/bin/enterpoint.sh && \
    echo '  nohup echo "check zookeeper sleep ......" >> ${FLUSS_HOME}/log/sleep.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo '  sleep 1s' >> /usr/local/bin/enterpoint.sh && \
    echo 'done' >> /usr/local/bin/enterpoint.sh && \
    echo 'sleep 30s' >> /usr/local/bin/enterpoint.sh && \
    echo 'hdfs dfs -mkdir -p /lakehouse/fluss/fluss-remote-data' >> /usr/local/bin/enterpoint.sh && \
    echo 'hdfs dfs -mkdir -p /hadoop/conf /hive/conf' >> /usr/local/bin/enterpoint.sh && \
    echo 'hdfs dfs -put -f ${HADOOP_HOME}/etc/hadoop/* /hadoop/conf/' >> /usr/local/bin/enterpoint.sh && \
    echo 'hdfs dfs -put -f ${HIVE_HOME}/conf/* /hive/conf/' >> /usr/local/bin/enterpoint.sh && \
    echo 'yarn-session.sh -nm fluss-yarn-session -Drest.port=8081 -Dexecution.checkpointing.interval=5s -d > /tmp/1.log 2>&1 &'  >> /usr/local/bin/enterpoint.sh && \
    echo 'while [[ `echo -e '"'"'\\n'"'"' | telnet hadoop 8081 2>/dev/null | grep Connected | wc -l` -eq 0 ]]' >> /usr/local/bin/enterpoint.sh && \
    echo 'do' >> /usr/local/bin/enterpoint.sh && \
    echo '  nohup echo "check flink on yarn sleep ......" >> ${FLUSS_HOME}/log/sleep.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo '  sleep 1s' >> /usr/local/bin/enterpoint.sh && \
    echo 'done' >> /usr/local/bin/enterpoint.sh && \
    echo 'while [[ `echo -e '"'"'\\n'"'"' | telnet hive 9083 2>/dev/null | grep Connected | wc -l` -eq 0 ]]' >> /usr/local/bin/enterpoint.sh && \
    echo 'do' >> /usr/local/bin/enterpoint.sh && \
    echo '  nohup echo "check hive sleep ......" >> ${FLUSS_HOME}/log/sleep.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo '  sleep 1s' >> /usr/local/bin/enterpoint.sh && \
    echo 'done' >> /usr/local/bin/enterpoint.sh && \
    echo 'local-cluster.sh start' >> /usr/local/bin/enterpoint.sh && \
    echo 'while [[ `echo -e '"'"'\\n'"'"' | telnet fluss 9123 2>/dev/null | grep Connected | wc -l` -eq 0 ]]' >> /usr/local/bin/enterpoint.sh && \
    echo 'do' >> /usr/local/bin/enterpoint.sh && \
    echo '  nohup echo "check fluss sleep ......" >> ${FLUSS_HOME}/log/sleep.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo '  sleep 1s' >> /usr/local/bin/enterpoint.sh && \
    echo 'done' >> /usr/local/bin/enterpoint.sh && \
    echo "flink run-application -t yarn-application ${FLINK_HOME}/lib/fluss-flink-tiering-${FLUSS_VERSION}.jar --fluss.bootstrap.servers fluss:9123 --datalake.format paimon --datalake.paimon.metastore hive --datalake.paimon.uri thrift://hive:9083 --datalake.paimon.warehouse hdfs:///warehouse/tablespace/managed/hive --datalake.paimon.hadoop-conf-dir hdfs:///hadoop/conf --datalake.paimon.hive-conf-dir hdfs:///hive/conf" >> /usr/local/bin/enterpoint.sh && \
    echo 'sleep infinity' >> /usr/local/bin/enterpoint.sh
