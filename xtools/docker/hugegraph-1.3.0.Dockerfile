FROM 10.10.52.13:5000/lakehouse/ubuntu:20.04.j

ARG HUGEGRAPH_VERSION="1.3.0"

RUN wget -P /usr/local/src/ https://archive.apache.org/dist/incubator/hugegraph/1.3.0/apache-hugegraph-incubating-1.3.0.tar.gz && \
    tar zxvf /usr/local/src/apache-hugegraph-incubating-1.3.0.tar.gz -C /usr/local/ && \
    rm -rf /usr/local/src/apache-hugegraph-incubating-1.3.0.tar.gz

COPY /dependency/hugegraph-${HUGEGRAPH_VERSION}/rest-server.properties /usr/local/apache-hugegraph-incubating-${HUGEGRAPH_VERSION}/conf/
COPY /dependency/hugegraph-${HUGEGRAPH_VERSION}/gremlin-server.yaml /usr/local/apache-hugegraph-incubating-${HUGEGRAPH_VERSION}/conf/
COPY /dependency/hugegraph-${HUGEGRAPH_VERSION}/remote.yaml /usr/local/apache-hugegraph-incubating-${HUGEGRAPH_VERSION}/conf/
COPY /dependency/hugegraph-${HUGEGRAPH_VERSION}/gremlin-connect.conf /usr/local/apache-hugegraph-incubating-${HUGEGRAPH_VERSION}/conf/
COPY /dependency/hugegraph-${HUGEGRAPH_VERSION}/gremlin-remote.sh /usr/local/apache-hugegraph-incubating-${HUGEGRAPH_VERSION}/bin/
COPY /dependency/hugegraph-${HUGEGRAPH_VERSION}/empty-sample.groovy /usr/local/apache-hugegraph-incubating-${HUGEGRAPH_VERSION}/scripts/
COPY /dependency/hugegraph-${HUGEGRAPH_VERSION}/example.groovy /usr/local/apache-hugegraph-incubating-${HUGEGRAPH_VERSION}/scripts/
COPY /dependency/hugegraph-${HUGEGRAPH_VERSION}/hugegraph.properties /usr/local/apache-hugegraph-incubating-${HUGEGRAPH_VERSION}/conf/graphs/
COPY /dependency/hugegraph-${HUGEGRAPH_VERSION}/social.properties /usr/local/apache-hugegraph-incubating-${HUGEGRAPH_VERSION}/conf/graphs/
COPY /dependency/hugegraph-${HUGEGRAPH_VERSION}/hugegraph-hubble.properties /usr/local/apache-hugegraph-toolchain-incubating-${HUGEGRAPH_VERSION}/apache-hugegraph-hubble-incubating-${HUGEGRAPH_VERSION}/conf/

RUN mkdir -p /data/hadoop/dfs/name /data/hadoop/dfs/data /data/hadoop/tmp && \
    echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /etc/profile && \
    echo "export HUGEGRAPH_HOME=/usr/local/apache-hugegraph-incubating-${HUGEGRAPH_VERSION}" >> /etc/profile && \
    echo 'export PATH=${PATH}:${JAVA_HOME}/bin:${HUGEGRAPH_HOME}/bin' >> /etc/profile

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV HUGEGRAPH_HOME /usr/local/apache-hugegraph-incubating-${HUGEGRAPH_VERSION}
ENV PATH ${PATH}:${JAVA_HOME}/bin:${HUGEGRAPH_HOME}/bin

RUN cd ${HUGEGRAPH_HOME} && bin/init-store.sh

RUN chmod 755 ${HUGEGRAPH_HOME}/bin/*.sh && \
    echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo 'source /etc/profile' >> /usr/local/bin/enterpoint.sh && \
    echo 'cd ${HUGEGRAPH_HOME} && bin/start-hugegraph.sh -p true' >> /usr/local/bin/enterpoint.sh && \
    echo "cd /usr/local/apache-hugegraph-toolchain-incubating-${HUGEGRAPH_VERSION}/apache-hugegraph-hubble-incubating-${HUGEGRAPH_VERSION} && bin/start-hubble.sh" >> /usr/local/bin/enterpoint.sh && \
    echo 'sleep infinity' >> /usr/local/bin/enterpoint.sh

WORKDIR ${HUGEGRAPH_HOME}

ENTRYPOINT ["/bin/bash", "/usr/local/bin/enterpoint.sh"]