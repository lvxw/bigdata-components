FROM 10.10.52.13:5000/lakehouse/docker:28.1.1

ARG FLINK_MAIN_VERSION="1.20"
ARG FLINK_VERSION="${FLINK_MAIN_VERSION}.3"
ARG INLONG_VERSION="2.3.0"

RUN apt-get update && \
    apt-get -y install openjdk-21-jdk&& \
    apt-get clean

RUN echo '}' >> /etc/profile && \
    echo '{"storage-driver": "vfs"}'> /etc/docker/daemon.json && \
    wget -O /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/v2.29.4/docker-compose-linux-x86_64 && \
    chmod 755 /usr/local/bin/docker-compose

ADD /dependency/inlong-${INLONG_VERSION}/apache-inlong-${INLONG_VERSION}-bin.tar.gz /usr/local/
#RUN wget -P /usr/local/src/ https://archive.apache.orgdocker:/dist/inlong/${INLONG_VERSION}/apache-inlong-${INLONG_VERSION}-bin.tar.gz && \
#    tar zxvf /usr/local/src/apache-inlong-${INLONG_VERSION}-bin.tar.gz -C /usr/local/ && \
#    rm -rf /usr/local/src/apache-inlong-${INLONG_VERSION}-bin.tar.gz

COPY /dependency/inlong-${INLONG_VERSION}/inlong.conf /usr/local/apache-inlong-${INLONG_VERSION}/conf/

RUN dos2unix /usr/local/apache-inlong-${INLONG_VERSION}/conf/inlong.conf && \
    mkdir -p /usr/local/apache-inlong-${INLONG_VERSION}/inlong-dataproxy/logs && \
    wget -P /usr/local/apache-inlong-${INLONG_VERSION}/inlong-agent/lib/ https://repo.maven.apache.org/maven2/mysql/mysql-connector-java/8.0.28/mysql-connector-java-8.0.28.jar && \
    cp /usr/local/apache-inlong-${INLONG_VERSION}/inlong-agent/lib/mysql-connector-java-8.0.28.jar  /usr/local/apache-inlong-${INLONG_VERSION}/inlong-audit/lib/ && \
    cp /usr/local/apache-inlong-${INLONG_VERSION}/inlong-agent/lib/mysql-connector-java-8.0.28.jar  /usr/local/apache-inlong-${INLONG_VERSION}/inlong-manager/lib/ && \
    cp /usr/local/apache-inlong-${INLONG_VERSION}/inlong-agent/lib/mysql-connector-java-8.0.28.jar  /usr/local/apache-inlong-${INLONG_VERSION}/inlong-tubemq-manager/lib/

RUN echo "export INLONG_HOME=/usr/local/apache-inlong-${INLONG_VERSION}" >> /etc/profile && \
    echo 'export PATH=${PATH}:${INLONG_HOME}/bin' >> /etc/profile

ENV INLONG_HOME /usr/local/apache-inlong-${INLONG_VERSION}
ENV PATH ${PATH}:${INLONG_HOME}/bin

WORKDIR /usr/local/apache-inlong-${INLONG_VERSION}

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo 'sleep infinity' >> /usr/local/bin/enterpoint.sh