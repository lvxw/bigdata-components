FROM 10.10.52.13:5000/lakehouse/ubuntu:20.04.b

USER root

ENV LANG C.UTF-8

COPY /dependency/common/sources.list /etc/apt/

RUN apt-get update && \
    apt-get -y install vim dos2unix net-tools iputils-ping telnet rsync wget tree openjdk-17-jdk netcat curl && \
    apt-get clean && \
    rm -rf /etc/localtime && \
    ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ARG PULSAR_VERSION="2.11.1"

RUN wget -P /usr/local/src/ https://archive.apache.org/dist/pulsar/pulsar-${PULSAR_VERSION}/apache-pulsar-${PULSAR_VERSION}-bin.tar.gz && \
    tar zxvf /usr/local/src/apache-pulsar-${PULSAR_VERSION}-bin.tar.gz -C /usr/local/ && \
    rm -rf /usr/local/src/apache-pulsar-${PULSAR_VERSION}-bin.tar.gz

RUN wget -P /usr/local/apache-pulsar-${PULSAR_VERSION}/lib/ https://repo.maven.apache.org/maven2/org/apache/hadoop/hadoop-hdfs-client/3.1.4/hadoop-hdfs-client-3.1.4.jar && \
    wget -P /usr/local/apache-pulsar-${PULSAR_VERSION}/lib/ https://repo.maven.apache.org/maven2/org/apache/hadoop/hadoop-common/3.1.4/hadoop-common-3.1.4.jar && \
    wget -P /usr/local/apache-pulsar-${PULSAR_VERSION}/lib/ https://repo.maven.apache.org/maven2/com/fasterxml/woodstox/woodstox-core/5.0.3/woodstox-core-5.0.3.jar && \
    wget -P /usr/local/apache-pulsar-${PULSAR_VERSION}/lib/ https://repo.maven.apache.org/maven2/org/codehaus/woodstox/stax2-api/3.1.4/stax2-api-3.1.4.jar && \
    wget -P /usr/local/apache-pulsar-${PULSAR_VERSION}/lib/ https://repo.maven.apache.org/maven2/commons-collections/commons-collections/3.2.2/commons-collections-3.2.2.jar && \
    wget -P /usr/local/apache-pulsar-${PULSAR_VERSION}/lib/ https://repo.maven.apache.org/maven2/org/apache/commons/commons-configuration2/2.1.1/commons-configuration2-2.1.1.jar && \
    wget -P /usr/local/apache-pulsar-${PULSAR_VERSION}/lib/ https://repo.maven.apache.org/maven2/org/apache/hadoop/hadoop-auth/3.1.4/hadoop-auth-3.1.4.jar && \
    wget -P /usr/local/apache-pulsar-${PULSAR_VERSION}/lib/ https://repo.maven.apache.org/maven2/org/apache/htrace/htrace-core4/4.1.0-incubating/htrace-core4-4.1.0-incubating.jar && \
    wget -P /usr/local/src/ https://archive.apache.org/dist/pulsar/pulsar-${PULSAR_VERSION}/apache-pulsar-offloaders-${PULSAR_VERSION}-bin.tar.gz && \
    tar zxvf /usr/local/src/apache-pulsar-offloaders-${PULSAR_VERSION}-bin.tar.gz -C /usr/local/src/ && \
    mkdir -p mkdir -p /usr/local/apache-pulsar-${PULSAR_VERSION}/offloaders && \
    cp /usr/local/src/apache-pulsar-offloaders-${PULSAR_VERSION}/offloaders/tiered-storage-file-system-${PULSAR_VERSION}.nar  /usr/local/apache-pulsar-${PULSAR_VERSION}/offloaders/ && \
    rm -rf  /usr/local/src/apache-pulsar-offloaders-${PULSAR_VERSION}-bin.tar.gz /usr/local/src/apache-pulsar-offloaders-${PULSAR_VERSION}
COPY /dependency/pulsar-${PULSAR_VERSION}/broker.conf /usr/local/apache-pulsar-${PULSAR_VERSION}/conf/
COPY /dependency/pulsar-${PULSAR_VERSION}/filesystem_offload_core_site.xml /usr/local/apache-pulsar-${PULSAR_VERSION}/conf/
COPY /dependency/pulsar-${PULSAR_VERSION}/client.conf /usr/local/apache-pulsar-${PULSAR_VERSION}/conf/

RUN echo "export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64" >> /etc/profile && \
    echo "export PULSAR_HOME=/usr/local/apache-pulsar-${PULSAR_VERSION}" >> /etc/profile && \
    echo 'export PATH=${PATH}:${JAVA_HOME}/bin:${PULSAR_HOME}/bin' >> /etc/profile

ENV JAVA_HOME /usr/lib/jvm/java-17-openjdk-amd64
ENV PULSAR_HOME /usr/local/apache-pulsar-${PULSAR_VERSION}
ENV PATH ${PATH}:${PULSAR_HOME}/bin:${JAVA_HOME}/bin

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo 'source /etc/profile' >> /usr/local/bin/enterpoint.sh && \
    echo 'pulsar initialize-cluster-metadata \' >> /usr/local/bin/enterpoint.sh && \
    echo '  --cluster pulsar-cluster \' >> /usr/local/bin/enterpoint.sh && \
    echo '  --existing-bk-metadata-service-uri "zk+hierarchical://zookeeper:2181/ledgers" \' >> /usr/local/bin/enterpoint.sh && \
    echo '  --zookeeper zookeeper:2181/pulsar \' >> /usr/local/bin/enterpoint.sh && \
    echo '  --configuration-store zookeeper:2181/pulsar \' >> /usr/local/bin/enterpoint.sh && \
    echo '  --web-service-url http://pulsar:8082 \' >> /usr/local/bin/enterpoint.sh && \
    echo '  --broker-service-url pulsar://pulsar:6650' >> /usr/local/bin/enterpoint.sh && \
    echo 'pulsar-daemon start broker' >> /usr/local/bin/enterpoint.sh && \
    echo 'tail -f /root/.bashrc' >> /usr/local/bin/enterpoint.sh

ENTRYPOINT ["/bin/bash", "/usr/local/bin/enterpoint.sh"]
