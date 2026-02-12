FROM 10.10.52.13:5000/lakehouse/flink:1.20.3

ARG AMORO_VERSION="0.8.1-incubating"
ARG SPARK_MAIN_VERSION="3.5"
ARG SPARK_VERSION="${SPARK_MAIN_VERSION}.4"
ARG PAIMON_VERSION="0.9.0"

RUN wget -P /usr/local/src/ https://archive.apache.org/dist/incubator/amoro/${AMORO_VERSION}/apache-amoro-${AMORO_VERSION}-bin-hadoop3.tar.gz && \
    tar zxvf /usr/local/src/apache-amoro-${AMORO_VERSION}-bin-hadoop3.tar.gz -C /usr/local/ && \
    rm -rf /usr/local/src/apache-amoro-${AMORO_VERSION}-bin-hadoop3.tar.gz && \
    wget -P /usr/local/src/ https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop3.tgz && \
    tar zxvf /usr/local/src/spark-${SPARK_VERSION}-bin-hadoop3.tgz -C /usr/local/ && \
    rm -rf /usr/local/src/spark-${SPARK_VERSION}-bin-hadoop3.tgz

COPY /dependency/amoro-${AMORO_VERSION}/config.yaml /usr/local/amoro-${AMORO_VERSION}/conf/
RUN wget -P /usr/local/amoro-${AMORO_VERSION}/lib/ https://repo.maven.apache.org/maven2/org/apache/amoro/amoro-format-paimon/${AMORO_VERSION}/amoro-format-paimon-${AMORO_VERSION}.jar && \
    wget -P /usr/local/amoro-${AMORO_VERSION}/lib/  https://repo.maven.apache.org/maven2/org/apache/paimon/paimon-bundle/${PAIMON_VERSION}/paimon-bundle-${PAIMON_VERSION}.jar && \
    wget -P /usr/local/amoro-${AMORO_VERSION}/plugin/optimizer/spark/ -O optimizer-job.jar https://repo.maven.apache.org/maven2/org/apache/amoro/amoro-optimizer-spark/${AMORO_VERSION}/amoro-optimizer-spark-${AMORO_VERSION}.jar && \
    wget -P /usr/local/amoro-${AMORO_VERSION}/plugin/optimizer/flink/ -O optimizer-job.jar https://repo.maven.apache.org/maven2/org/apache/amoro/amoro-optimizer-flink/${AMORO_VERSION}/amoro-optimizer-flink-${AMORO_VERSION}-jar-with-dependencies.jar && \
    wget -P /usr/local/amoro-${AMORO_VERSION}/lib/ https://repo.maven.apache.org/maven2/org/apache/paimon/paimon-spark-3.5/${PAIMON_VERSION}/paimon-spark-3.5-${PAIMON_VERSION}.jar && \
    wget -P /usr/local/amoro-${AMORO_VERSION}/lib/ https://repo.maven.apache.org/maven2/mysql/mysql-connector-java/8.0.28/mysql-connector-java-8.0.28.jar


RUN echo "export AMORO_HOME=/usr/local/amoro-${AMORO_VERSION}" >> /etc/profile && \
    echo 'export PATH=${PATH}:${AMORO_HOME}/bin' >> /etc/profile && \
    echo "export SPARK_HOME=/usr/local/spark-${SPARK_VERSION}-bin-hadoop3" >> /etc/profile && \
    echo 'export PATH=${PATH}:${AMORO_HOME}/bin:${SPARK_HOME}/bin' >> /etc/profile && \
    rm -rf /usr/local/bin/enter-beeline.sh /usr/local/bin/enter-sql-client.sh /usr/local/bin/mc && \
    rm -rf ${FLINK_HOME}/lib/paimon-*.jar  ${FLINK_HOME}/lib/fluss-*.jar && \
    cp /usr/local/amoro-${AMORO_VERSION}/lib/args4j-2.33.jar /usr/local/spark-${SPARK_VERSION}-bin-hadoop3/jars/ && \
    cp /usr/local/amoro-${AMORO_VERSION}/lib/amoro-shade-thrift-0.20.0-0.7.0-incubating.jar  /usr/local/spark-${SPARK_VERSION}-bin-hadoop3/jars/ && \
    cp /usr/local/amoro-${AMORO_VERSION}/lib/amoro-shade-guava-32-32.1.1-jre-0.7.0-incubating.jar /usr/local/spark-${SPARK_VERSION}-bin-hadoop3/jars/ && \
    cp /usr/local/amoro-${AMORO_VERSION}/lib/amoro-optimizer-common-${AMORO_VERSION}.jar /usr/local/spark-${SPARK_VERSION}-bin-hadoop3/jars/

ENV AMORO_HOME /usr/local/amoro-${AMORO_VERSION}
ENV PATH ${PATH}:${AMORO_HOME}/binR

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo 'ip_addr=`ip addr | grep -A 3 '"'"'eth0'"'"' |  grep '"'"'inet'"'"'  | awk '"'"'{print $2}'"'"' | awk -F '"'"'/'"'"' '"'"'{print $1}'"'"'`' >> /usr/local/bin/enterpoint.sh && \
    echo 'sed -i '"'"'s/server-expose-host: "127.0.0.1"/server-expose-host: {ip_addr}/'"'"' ${AMORO_HOME}/conf/config.yaml' >> /usr/local/bin/enterpoint.sh && \
    echo 'sed -i "s/server-expose-host: {ip_addr}/server-expose-host: '"'"'${ip_addr}'"'"'/" ${AMORO_HOME}/conf/config.yaml' >> /usr/local/bin/enterpoint.sh && \
    echo 'while [[ `echo -e '"'"'\\n'"'"' | telnet mysql 3306 2>/dev/null | grep Connected | wc -l` -eq 0 ]]' >> /usr/local/bin/enterpoint.sh && \
    echo 'do' >> /usr/local/bin/enterpoint.sh && \
    echo '  nohup echo "check mysql sleep ......" >> ${AMORO_HOME}/logs/sleep.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo '  sleep 1s' >> /usr/local/bin/enterpoint.sh && \
    echo 'done' >> /usr/local/bin/enterpoint.sh && \
    echo 'source /etc/profile' >> /usr/local/bin/enterpoint.sh && \
    echo 'ams.sh start' >> /usr/local/bin/enterpoint.sh && \
    echo 'sleep infinity' >> /usr/local/bin/enterpoint.sh
