FROM 10.10.52.13:5000/lakehouse/ubuntu:20.04.j

ARG BOOKKEEPER_VERSION="4.15.4"

RUN wget -P /usr/local/src/ https://archive.apache.org/dist/bookkeeper/bookkeeper-${BOOKKEEPER_VERSION}/bookkeeper-all-${BOOKKEEPER_VERSION}-bin.tar.gz && \
    tar zxvf /usr/local/src/bookkeeper-all-${BOOKKEEPER_VERSION}-bin.tar.gz -C /usr/local/ && \
    rm -rf /usr/local/src/bookkeeper-all-${BOOKKEEPER_VERSION}-bin.tar.gz

COPY /dependency/bookkeeper-${BOOKKEEPER_VERSION}/bk_server.conf /usr/local/bookkeeper-all-${BOOKKEEPER_VERSION}/conf/

RUN echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /etc/profile && \
    echo "export BOOKKEEPER_HOME=/usr/local/bookkeeper-all-${BOOKKEEPER_VERSION}" >> /etc/profile && \
    echo 'export PATH=${PATH}:${JAVA_HOME}/bin:${BOOKKEEPER_HOME}/bin' >> /etc/profile && \
    mkdir -p /data/journal /data/ledger /data/index /usr/local/bookkeeper-all-${BOOKKEEPER_VERSION}/logs

ENV BOOKKEEPER_HOME /usr/local/bookkeeper-all-${BOOKKEEPER_VERSION}
ENV PATH ${PATH}:${BOOKKEEPER_HOME}/bin

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo 'source /etc/profile' >> /usr/local/bin/enterpoint.sh && \
    echo 'bookkeeper shell metaformat -n -f' >> /usr/local/bin/enterpoint.sh && \
    echo 'bookkeeper-daemon.sh start bookie' >> /usr/local/bin/enterpoint.sh && \
    echo 'tail -f /root/.bashrc' >> /usr/local/bin/enterpoint.sh

ENTRYPOINT ["/bin/bash", "/usr/local/bin/enterpoint.sh"]