FROM 10.10.52.13:5000/lakehouse/ubuntu:20.04.j

ARG SCHEMA_REGISTRY_VERSION="6.2.1"

RUN wget -P /usr/local/src/ https://packages.confluent.io/archive/6.2/confluent-community-${SCHEMA_REGISTRY_VERSION}.tar.gz && \
    tar zxvf /usr/local/src/confluent-community-${SCHEMA_REGISTRY_VERSION}.tar.gz -C /usr/local/ && \
    rm -rf /usr/local/src/confluent-community-${SCHEMA_REGISTRY_VERSION}.tar.gz

COPY /dependency/schema-registry-${SCHEMA_REGISTRY_VERSION}/schema-registry.properties /usr/local/confluent-${SCHEMA_REGISTRY_VERSION}/etc/schema-registry/

RUN mkdir -p /usr/local/confluent-${SCHEMA_REGISTRY_VERSION}/logs && \
    echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /etc/profile && \
    echo "export SCHEMA_REGISTRY_HOME=/usr/local/confluent-${SCHEMA_REGISTRY_VERSION}" >> /etc/profile && \
    echo 'export PATH=${PATH}:${JAVA_HOME}/bin:${SCHEMA_REGISTRY_HOME}/bin' >> /etc/profile

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV SCHEMA_REGISTRY_HOME /usr/local/confluent-${SCHEMA_REGISTRY_VERSION}
ENV PATH ${PATH}:${JAVA_HOME}/bin:${SCHEMA_REGISTRY_HOME}/bin

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo 'while [[ `echo -e '"'"'\\n'"'"' | telnet kafka 9092 2>/dev/null | grep Connected | wc -l` -eq 0 ]]' >> /usr/local/bin/enterpoint.sh && \
    echo 'do' >> /usr/local/bin/enterpoint.sh && \
    echo '  nohup echo "check kafka sleep ......" >> ${SCHEMA_REGISTRY_HOME}/logs/sleep.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo '  sleep 1s' >> /usr/local/bin/enterpoint.sh && \
    echo 'done' >> /usr/local/bin/enterpoint.sh && \
    echo 'schema-registry-start -daemon ${SCHEMA_REGISTRY_HOME}/etc/schema-registry/schema-registry.properties' >> /usr/local/bin/enterpoint.sh && \
    echo 'sleep infinity' >> /usr/local/bin/enterpoint.sh

ENTRYPOINT ["/bin/bash", "/usr/local/bin/enterpoint.sh"]
