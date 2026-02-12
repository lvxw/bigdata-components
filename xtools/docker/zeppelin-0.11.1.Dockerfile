FROM 10.10.52.13:5000/lakehouse/flink:1.19.1

ARG ZEPPELIN_VERSION="0.11.1"

RUN wget -P /usr/local/src/ https://archive.apache.org/dist/zeppelin/zeppelin-${ZEPPELIN_VERSION}/zeppelin-${ZEPPELIN_VERSION}-bin-all.tgz && \
    tar zxvf /usr/local/src/zeppelin-${ZEPPELIN_VERSION}-bin-all.tgz -C /usr/local/ && \
    rm -rf /usr/local/src/zeppelin-${ZEPPELIN_VERSION}-bin-all.tgz

COPY /dependency/zeppelin-${ZEPPELIN_VERSION}/zeppelin-env.sh /usr/local/zeppelin-${ZEPPELIN_VERSION}-bin-all/conf/
COPY /dependency/zeppelin-${ZEPPELIN_VERSION}/zeppelin-site.xml /usr/local/zeppelin-${ZEPPELIN_VERSION}-bin-all/conf/

RUN find /usr/local/zeppelin-${ZEPPELIN_VERSION}-bin-all/ -type f -name "*._*" | sed 's/ /\\ /g'  | xargs  rm -rf && \
    echo "export ZEPPELIN_HOME=/usr/local/zeppelin-${ZEPPELIN_VERSION}-bin-all" >> /etc/profile && \
    echo 'export PATH=${PATH}:${ZEPPELIN_HOME}/bin' >> /etc/profile

ENV ZEPPELIN_HOME /usr/local/zeppelin-${ZEPPELIN_VERSION}-bin-all
ENV PATH ${PATH}:${ZEPPELIN_HOME}/bin

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo 'cd ${ZEPPELIN_HOME} &&  bin/zeppelin-daemon.sh start' >> /usr/local/bin/enterpoint.sh && \
    echo 'tail -f /root/.bashrc' >> /usr/local/bin/enterpoint.sh
