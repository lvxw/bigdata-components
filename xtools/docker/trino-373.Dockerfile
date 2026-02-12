FROM 10.10.52.13:5000/lakehouse/ubuntu:20.04.b

USER root

ENV LANG C.UTF-8

COPY /dependency/common/sources.list /etc/apt/

RUN apt-get update && \
    apt-get -y install python3 openjdk-11-jdk less && \
    ln -s /usr/bin/python3 /usr/bin/python

ARG TRINO_VERSION="373"
ARG PAIMON_MAIN_VERSION="0.8"

RUN wget -P /usr/local/src/ https://repo1.maven.org/maven2/io/trino/trino-server/373/trino-server-${TRINO_VERSION}.tar.gz && \
    tar zxvf /usr/local/src/trino-server-${TRINO_VERSION}.tar.gz -C /usr/local/ && \
    rm -rf /usr/local/src/trino-server-${TRINO_VERSION}.tar.gz

RUN wget -P /usr/local/trino-server-${TRINO_VERSION}/bin/ https://repo1.maven.org/maven2/io/trino/trino-cli/${TRINO_VERSION}/trino-cli-${TRINO_VERSION}-executable.jar && \
    wget -P /usr/local/trino-server-${TRINO_VERSION}/plugin/ https://repository.apache.org/content/repositories/snapshots/org/apache/paimon/paimon-trino-370/${PAIMON_MAIN_VERSION}-SNAPSHOT/paimon-trino-370-${PAIMON_MAIN_VERSION}-20240314.001010-21-plugin.tar.gz

COPY /dependency/trino-${TRINO_VERSION}/config.properties /usr/local/trino-server-${TRINO_VERSION}/etc/
COPY /dependency/trino-${TRINO_VERSION}/jvm.config /usr/local/trino-server-${TRINO_VERSION}/etc/
COPY /dependency/trino-${TRINO_VERSION}/log.properties /usr/local/trino-server-${TRINO_VERSION}/etc/
COPY /dependency/trino-${TRINO_VERSION}/node.properties /usr/local/trino-server-${TRINO_VERSION}/etc/
COPY /dependency/trino-${TRINO_VERSION}/jmx.properties /usr/local/trino-server-${TRINO_VERSION}/etc/catalog/
COPY /dependency/trino-${TRINO_VERSION}/hive.properties /usr/local/trino-server-${TRINO_VERSION}/etc/catalog/
COPY /dependency/trino-${TRINO_VERSION}/paimon.properties /usr/local/trino-server-${TRINO_VERSION}/etc/catalog/

RUN chmod 755  /usr/local/trino-server-${TRINO_VERSION}/bin/trino-cli-${TRINO_VERSION}-executable.jar && \
    echo '#!/bin/bash' > /usr/local/trino-server-${TRINO_VERSION}/bin/trino-cli && \
    echo 'trino-cli-${TRINO_VERSION}-executable.jar --server trino:8087 $*' >> /usr/local/trino-server-${TRINO_VERSION}/bin/trino-cli && \
    chmod 755 /usr/local/trino-server-${TRINO_VERSION}/bin/trino-cli && \
    echo "export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64" >> /etc/profile && \
    echo "export TRINO_HOME=/usr/local/trino-server-${TRINO_VERSION}" >> /etc/profile && \
    echo 'export PATH=${PATH}:${JAVA_HOME}/bin:${TRINO_HOME}/bin' >> /etc/profile

ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64
ENV TRINO_HOME /usr/local/trino-server-${TRINO_VERSION}
ENV PATH ${PATH}:${JAVA_HOME}/bin:${TRINO_HOME}/bin
ENV TZ=Asia/Shanghai

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo "source /etc/profile" >> /usr/local/bin/enterpoint.sh && \
    echo "cd /usr/local/trino-server-${TRINO_VERSION}" >> /usr/local/bin/enterpoint.sh && \
    echo 'bin/launcher start' >> /usr/local/bin/enterpoint.sh && \
    echo 'tail -f /root/.bashrc' >> /usr/local/bin/enterpoint.sh


ENTRYPOINT ["/bin/bash", "/usr/local/bin/enterpoint.sh"]