FROM 10.10.52.13:5000/lakehouse/hadoop:3.1.4

ARG HBASE_VERSION="2.4.9"

RUN wget -P /usr/local/src/ https://archive.apache.org/dist/hbase/${HBASE_VERSION}/hbase-${HBASE_VERSION}-bin.tar.gz && \
    tar zxvf /usr/local/src/hbase-${HBASE_VERSION}-bin.tar.gz -C /usr/local/ && \
    rm -rf /usr/local/src/hbase-${HBASE_VERSION}-bin.tar.gz


ADD /dependency/hbase-${HBASE_VERSION}/hbase-site.xml /usr/local/hbase-${HBASE_VERSION}/conf/
ADD /dependency/hbase-${HBASE_VERSION}/hbase-env.sh /usr/local/hbase-${HBASE_VERSION}/conf/

RUN echo "export HBASE_HOME=/usr/local/hbase-${HBASE_VERSION}" >> /etc/profile && \
    echo 'export PATH=${PATH}:${HBASE_HOME}/bin' >> /etc/profile

ENV HBASE_HOME /usr/local/hbase-${HBASE_VERSION}
ENV PATH ${PATH}:${HBASE_HOME}/bin

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo 'while [[ `echo -e '"'"'\\n'"'"' | telnet hadoop 8020 2>/dev/null | grep Connected | wc -l` -eq 0 ]]' >> /usr/local/bin/enterpoint.sh && \
    echo 'do' >> /usr/local/bin/enterpoint.sh && \
    echo '  nohup echo "check hadoop sleep ......" >> ${HBASE_HOME}/logs/sleep.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo '  sleep 1s' >> /usr/local/bin/enterpoint.sh && \
    echo 'done' >> /usr/local/bin/enterpoint.sh && \
    echo 'while [[ `echo -e '"'"'\\n'"'"' | telnet zookeeper 2181 2>/dev/null | grep Connected | wc -l` -eq 0 ]]' >> /usr/local/bin/enterpoint.sh && \
    echo 'do' >> /usr/local/bin/enterpoint.sh && \
    echo '  nohup echo "check zookeeper sleep ......" >> ${HBASE_HOME}/logs/sleep.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo '  sleep 1s' >> /usr/local/bin/enterpoint.sh && \
    echo 'done' >> /usr/local/bin/enterpoint.sh && \
    echo 'hbase-daemon.sh start master' >> /usr/local/bin/enterpoint.sh && \
    echo 'hbase-daemon.sh start regionserver' >> /usr/local/bin/enterpoint.sh && \
    echo 'sleep infinity' >> /usr/local/bin/enterpoint.sh
