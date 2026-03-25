FROM 10.10.52.13:5000/lakehouse/flink:1.20.3

ARG FLINK_MAIN_VERSION="1.20"
ARG FLINK_VERSION="${FLINK_MAIN_VERSION}.3"
ARG INLONG_VERSION="2.3.0"

ADD /dependency/inlong-${INLONG_VERSION}/apache-inlong-${INLONG_VERSION}-bin.tar.gz /usr/local/
#RUN wget -P /usr/local/src/ https://archive.apache.org/dist/inlong/${INLONG_VERSION}/apache-inlong-${INLONG_VERSION}-bin.tar.gz && \
#    tar zxvf /usr/local/src/apache-inlong-${INLONG_VERSION}-bin.tar.gz -C /usr/local/ && \
#    rm -rf /usr/local/src/apache-inlong-${INLONG_VERSION}-bin.tar.gz

COPY /dependency/inlong-${INLONG_VERSION}/inlong.conf /usr/local/apache-inlong-${INLONG_VERSION}/conf/

RUN wget -P /usr/local/apache-inlong-${INLONG_VERSION}/inlong-agent/lib/ https://repo.maven.apache.org/maven2/mysql/mysql-connector-java/8.0.28/mysql-connector-java-8.0.28.jar && \
    cp /usr/local/apache-inlong-${INLONG_VERSION}/inlong-agent/lib/mysql-connector-java-8.0.28.jar  /usr/local/apache-inlong-${INLONG_VERSION}/inlong-audit/lib/ && \
    cp /usr/local/apache-inlong-${INLONG_VERSION}/inlong-agent/lib/mysql-connector-java-8.0.28.jar  /usr/local/apache-inlong-${INLONG_VERSION}/inlong-manager/lib/ && \
    cp /usr/local/apache-inlong-${INLONG_VERSION}/inlong-agent/lib/mysql-connector-java-8.0.28.jar  /usr/local/apache-inlong-${INLONG_VERSION}/inlong-tubemq-manager/lib/


RUN echo "export INLONG_HOME=/usr/local/apache-inlong-${INLONG_VERSION}" >> /etc/profile && \
    echo 'export PATH=${PATH}:${INLONG_HOME}/bin' >> /etc/profile

ENV INLONG_HOME /usr/local/apache-inlong-${INLONG_VERSION}
ENV PATH ${PATH}:${INLONG_HOME}/bin

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo 'sleep infinity' >> /usr/local/bin/enterpoint.sh