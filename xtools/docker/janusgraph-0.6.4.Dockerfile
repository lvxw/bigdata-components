FROM 10.10.52.13:5000/lakehouse/ubuntu:20.04.j

ARG JANUSGRAPH_VERSION="0.6.4"

RUN wget -P /usr/local/src/ https://github.com/JanusGraph/janusgraph/releases/download/v0.6.4/janusgraph-0.6.4.zip && \
    unzip /usr/local/src/janusgraph-${JANUSGRAPH_VERSION}.zip -d /usr/local/ && \
    rm -rf /usr/local/src/janusgraph-0.6.4.zip

COPY /dependency/janusgraph-${JANUSGRAPH_VERSION}/remote.yaml /usr/local/janusgraph-${JANUSGRAPH_VERSION}/conf/
COPY /dependency/janusgraph-${JANUSGRAPH_VERSION}/janusgraph-hbase-es.properties /usr/local/janusgraph-${JANUSGRAPH_VERSION}/conf/
COPY /dependency/janusgraph-${JANUSGRAPH_VERSION}/janusgraph-hbase-es2.properties /usr/local/janusgraph-${JANUSGRAPH_VERSION}/conf/
COPY /dependency/janusgraph-${JANUSGRAPH_VERSION}/gremlin-connect.conf /usr/local/janusgraph-${JANUSGRAPH_VERSION}/conf/
COPY /dependency/janusgraph-${JANUSGRAPH_VERSION}/empty-sample.groovy /usr/local/janusgraph-${JANUSGRAPH_VERSION}/scripts/
COPY /dependency/janusgraph-${JANUSGRAPH_VERSION}/gremlin-hbase-es-server.yaml /usr/local/janusgraph-${JANUSGRAPH_VERSION}/conf/gremlin-server/
COPY /dependency/janusgraph-${JANUSGRAPH_VERSION}/gremlin-remote.sh /usr/local/janusgraph-${JANUSGRAPH_VERSION}/bin/

ENV PATH ${PATH}:/usr/local/janusgraph-${JANUSGRAPH_VERSION}/bin

RUN chmod 755 /usr/local/janusgraph-${JANUSGRAPH_VERSION}/bin/*.sh && \
    echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo 'while [[ `echo -e '"'"'\\n'"'"' | telnet hbase 16000 2>/dev/null | grep Connected | wc -l` -eq 0 ]]' >> /usr/local/bin/enterpoint.sh && \
    echo 'do' >> /usr/local/bin/enterpoint.sh && \
    echo '  nohup echo "check hbase sleep ......" >> /usr/local/janusgraph-0.6.4/logs/sleep.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo '  sleep 1s' >> /usr/local/bin/enterpoint.sh && \
    echo 'done' >> /usr/local/bin/enterpoint.sh && \
    echo 'while [[ `echo -e '"'"'\\n'"'"' | telnet elasticsearch 9200 2>/dev/null | grep Connected | wc -l` -eq 0 ]]' >> /usr/local/bin/enterpoint.sh && \
    echo 'do' >> /usr/local/bin/enterpoint.sh && \
    echo '  nohup echo "check elasticsearch sleep ......" >> /usr/local/janusgraph-0.6.4/logs/sleep.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo '  sleep 1s' >> /usr/local/bin/enterpoint.sh && \
    echo 'done' >> /usr/local/bin/enterpoint.sh && \
    echo 'cd /usr/local/janusgraph-0.6.4 && nohup ./bin/janusgraph-server.sh console ./conf/gremlin-server/gremlin-hbase-es-server.yaml > /usr/local/janusgraph-0.6.4/logs/start.log  2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo 'sleep infinity' >> /usr/local/bin/enterpoint.sh

ENTRYPOINT ["/bin/bash", "/usr/local/bin/enterpoint.sh"]