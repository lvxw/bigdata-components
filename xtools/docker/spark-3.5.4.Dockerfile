FROM 10.10.52.13:5000/lakehouse/hive:3.1.3

ARG SPARK_MAIN_VERSION="3.5"
ARG SPARK_VERSION="${SPARK_MAIN_VERSION}.4"
ARG PAIMON_VERSION="1.3.1"
ARG GRAVITINO_VERSION="1.2.0"
ARG CELEBORN_VERSION="0.6.2"
ARG FLUSS_VERSION="0.9.0-incubating"

RUN wget -P /usr/local/src/ https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop3.tgz && \
    tar zxvf /usr/local/src/spark-${SPARK_VERSION}-bin-hadoop3.tgz -C /usr/local/ && \
    rm -rf /usr/local/src/spark-${SPARK_VERSION}-bin-hadoop3.tgz

COPY /dependency/spark-${SPARK_VERSION}/spark-defaults.conf /usr/local/spark-${SPARK_VERSION}-bin-hadoop3/conf/
COPY /dependency/spark-${SPARK_VERSION}/spark-sql-client.sh /usr/local/spark-${SPARK_VERSION}-bin-hadoop3/bin/
COPY /dependency/spark-${SPARK_VERSION}/spark-sql-gravitino.sh /usr/local/spark-${SPARK_VERSION}-bin-hadoop3/bin/

RUN wget -P /usr/local/spark-${SPARK_VERSION}-bin-hadoop3/jars/ https://repo.maven.apache.org/maven2/org/apache/paimon/paimon-spark-3.5/1.3.1/paimon-spark-3.5-1.3.1.jar && \
    wget -P /usr/local/spark-${SPARK_VERSION}-bin-hadoop3/jars/ https://repo.maven.apache.org/maven2/org/apache/gravitino/gravitino-spark-common/1.1.0/gravitino-spark-common-1.1.0.jar && \
    wget -P /usr/local/spark-${SPARK_VERSION}-bin-hadoop3/jars/ https://repo.maven.apache.org/maven2/org/apache/gravitino/gravitino-spark-connector-runtime-3.5_2.12/1.1.0/gravitino-spark-connector-runtime-3.5_2.12-1.1.0.jar && \
    wget -P /usr/local/spark-${SPARK_VERSION}-bin-hadoop3/jars/ https://repo.maven.apache.org/maven2/mysql/mysql-connector-java/8.0.28/mysql-connector-java-8.0.28.jar && \
    wget -P /usr/local/spark-${SPARK_VERSION}-bin-hadoop3/jars/ https://repo.maven.apache.org/maven2/org/apache/celeborn/celeborn-client-spark-3-shaded_2.12/${CELEBORN_VERSION}/celeborn-client-spark-3-shaded_2.12-${CELEBORN_VERSION}.jar && \
    wget -P /usr/local/spark-${SPARK_VERSION}-bin-hadoop3/jars/ https://repo1.maven.org/maven2/org/apache/fluss/fluss-spark-3.5_2.12/0.9.0-incubating/fluss-spark-3.5_2.12-0.9.0-incubating.jar

RUN echo "export SPARK_HOME=/usr/local/spark-${SPARK_VERSION}-bin-hadoop3" >> /etc/profile && \
    echo 'export PATH=${PATH}:${SPARK_HOME}/bin' >> /etc/profile && \
    cp ${HIVE_HOME}/conf/hive-site.xml /usr/local/spark-${SPARK_VERSION}-bin-hadoop3/conf/ && \
    chmod 755 /usr/local/spark-${SPARK_VERSION}-bin-hadoop3/bin/spark-sql-client.sh && \
    chmod 755 /usr/local/spark-${SPARK_VERSION}-bin-hadoop3/bin/spark-sql-gravitino.sh

ENV SPARK_HOME /usr/local/spark-${SPARK_VERSION}-bin-hadoop3
ENV PATH ${PATH}:${SPARK_HOME}/bin

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo 'tail -f /root/.bashrc' >> /usr/local/bin/enterpoint.sh \
