FROM 10.10.52.13:5000/lakehouse/spark:3.5.4

ARG SEATUNNEL_VERSION="2.3.12"

RUN wget -P /usr/local/src/ https://archive.apache.org/dist/seatunnel/${SEATUNNEL_VERSION}/apache-seatunnel-${SEATUNNEL_VERSION}-bin.tar.gz && \
    tar zxvf /usr/local/src/apache-seatunnel-${SEATUNNEL_VERSION}-bin.tar.gz -C /usr/local/ && \
    rm -rf /usr/local/src/apache-seatunnel-${SEATUNNEL_VERSION}-bin.tar.gz

COPY /dependency/seatunnel-${SEATUNNEL_VERSION}/seatunnel.yaml /usr/local/apache-seatunnel-${SEATUNNEL_VERSION}/conf/
COPY /dependency/seatunnel-${SEATUNNEL_VERSION}/hazelcast-client.yaml /usr/local/apache-seatunnel-${SEATUNNEL_VERSION}/conf/
COPY /dependency/seatunnel-${SEATUNNEL_VERSION}/hazelcast-master.yaml /usr/local/apache-seatunnel-${SEATUNNEL_VERSION}/conf/
COPY /dependency/seatunnel-${SEATUNNEL_VERSION}/hazelcast-worker.yaml /usr/local/apache-seatunnel-${SEATUNNEL_VERSION}/conf/

RUN wget -P /usr/local/apache-seatunnel-${SEATUNNEL_VERSION}/connectors/ https://repo.maven.apache.org/maven2/org/apache/seatunnel/connector-doris/${SEATUNNEL_VERSION}/connector-doris-${SEATUNNEL_VERSION}.jar && \
    wget -P /usr/local/apache-seatunnel-${SEATUNNEL_VERSION}/connectors/ https://repo.maven.apache.org/maven2/org/apache/seatunnel/connector-file-hadoop/${SEATUNNEL_VERSION}/connector-file-hadoop-${SEATUNNEL_VERSION}.jar && \
    wget -P /usr/local/apache-seatunnel-${SEATUNNEL_VERSION}/connectors/ https://repo.maven.apache.org/maven2/org/apache/seatunnel/connector-file-s3/${SEATUNNEL_VERSION}/connector-file-s3-${SEATUNNEL_VERSION}.jar && \
    wget -P /usr/local/apache-seatunnel-${SEATUNNEL_VERSION}/connectors/ https://repo.maven.apache.org/maven2/org/apache/seatunnel/connector-hbase/${SEATUNNEL_VERSION}/connector-hbase-${SEATUNNEL_VERSION}.jar && \
    wget -P /usr/local/apache-seatunnel-${SEATUNNEL_VERSION}/connectors/ https://repo.maven.apache.org/maven2/org/apache/seatunnel/connector-hive/${SEATUNNEL_VERSION}/connector-hive-${SEATUNNEL_VERSION}.jar && \
    wget -P /usr/local/apache-seatunnel-${SEATUNNEL_VERSION}/connectors/ https://repo.maven.apache.org/maven2/org/apache/seatunnel/connector-jdbc/${SEATUNNEL_VERSION}/connector-jdbc-${SEATUNNEL_VERSION}.jar && \
    wget -P /usr/local/apache-seatunnel-${SEATUNNEL_VERSION}/connectors/ https://repo.maven.apache.org/maven2/org/apache/seatunnel/connector-kafka/${SEATUNNEL_VERSION}/connector-kafka-${SEATUNNEL_VERSION}.jar && \
    wget -P /usr/local/apache-seatunnel-${SEATUNNEL_VERSION}/connectors/ https://repo.maven.apache.org/maven2/org/apache/seatunnel/connector-paimon/${SEATUNNEL_VERSION}/connector-paimon-${SEATUNNEL_VERSION}.jar

RUN echo "export SEATUNNEL_HOME=/usr/local/apache-seatunnel-${SEATUNNEL_VERSION}" >> /etc/profile && \
    echo 'export PATH=${PATH}:${SEATUNNEL_HOME}/bin' >> /etc/profile && \
    mkdir -p /usr/local/apache-seatunnel-${SEATUNNEL_VERSION}/logs

ENV SEATUNNEL_HOME /usr/local/apache-seatunnel-${SEATUNNEL_VERSION}
ENV PATH ${PATH}:${SEATUNNEL_HOME}/bin

WORKDIR ${SEATUNNEL_HOME}

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo 'source /etc/profile' >> /usr/local/bin/enterpoint.sh && \
    echo 'while [[ `echo -e '"'"'\\n'"'"' | telnet hadoop 8020 2>/dev/null | grep Connected | wc -l` -eq 0 ]]' >> /usr/local/bin/enterpoint.sh && \
    echo 'do' >> /usr/local/bin/enterpoint.sh && \
    echo '  nohup echo "check hadoop sleep ......" >> ${SEATUNNEL_VERSION}/logs/sleep.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo '  sleep 1s' >> /usr/local/bin/enterpoint.sh && \
    echo 'done' >> /usr/local/bin/enterpoint.sh && \
    echo 'hdfs dfs -mkdir -p /seatunnel/checkpoint_snapshot' > /usr/local/bin/enterpoint.sh && \
    echo 'seatunnel-cluster.sh -d' >> /usr/local/bin/enterpoint.sh && \
    echo 'sleep infinity' >> /usr/local/bin/enterpoint.sh