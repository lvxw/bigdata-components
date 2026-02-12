FROM 10.10.52.13:5000/lakehouse/ubuntu:20.04.j

ARG KAFKA_VERSION="2.8.2"

RUN wget -P /usr/local/src/ https://archive.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_2.12-${KAFKA_VERSION}.tgz && \
    tar zxvf /usr/local/src/kafka_2.12-${KAFKA_VERSION}.tgz -C /usr/local/ && \
    rm -rf /usr/local/src/kafka_2.12-${KAFKA_VERSION}.tgz

COPY /dependency/kafka-${KAFKA_VERSION}/server.properties /usr/local/kafka_2.12-${KAFKA_VERSION}/config/

RUN mkdir -p /usr/local/kafka_2.12-${KAFKA_VERSION}/logs && \
    echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /etc/profile && \
    echo "export KAFKA_HOME=/usr/local/kafka_2.12-${KAFKA_VERSION}" >> /etc/profile && \
    echo 'export PATH=${PATH}:${JAVA_HOME}/bin:${KAFKA_HOME}/bin' >> /etc/profile

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV KAFKA_HOME /usr/local/kafka_2.12-${KAFKA_VERSION}
ENV PATH ${PATH}:${JAVA_HOME}/bin:${KAFKA_HOME}/bin

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo 'while [[ `echo -e '"'"'\\n'"'"' | telnet zookeeper 2181 2>/dev/null | grep Connected | wc -l` -eq 0 ]]' >> /usr/local/bin/enterpoint.sh && \
    echo 'do' >> /usr/local/bin/enterpoint.sh && \
    echo '  nohup echo "check zookeeper sleep ......" >> ${KAFKA_HOME}/logs/sleep.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo '  sleep 1s' >> /usr/local/bin/enterpoint.sh && \
    echo 'done' >> /usr/local/bin/enterpoint.sh && \
    echo 'kafka-server-start.sh -daemon ${KAFKA_HOME}/config/server.properties' >> /usr/local/bin/enterpoint.sh && \
    echo 'tail -f /root/.bashrc' >> /usr/local/bin/enterpoint.sh

ENTRYPOINT ["/bin/bash", "/usr/local/bin/enterpoint.sh"]