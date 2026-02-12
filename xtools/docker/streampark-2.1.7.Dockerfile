FROM 10.10.52.13:5000/lakehouse/flink:1.20.3

ARG STREAMPARK_VERSION="2.1.7"

RUN wget -P /usr/local/src/ https://archive.apache.org/dist/streampark/${STREAMPARK_VERSION}/apache-streampark_2.12-${STREAMPARK_VERSION}-bin.tar.gz && \
    tar zxvf /usr/local/src/apache-streampark_2.12-${STREAMPARK_VERSION}-bin.tar.gz -C /usr/local/ && \
    rm -rf /usr/local/src/apache-streampark_2.12-${STREAMPARK_VERSION}-bin.tar.gz

RUN wget -P /usr/local/apache-streampark_2.12-${STREAMPARK_VERSION}-bin/lib/ https://repo.maven.apache.org/maven2/mysql/mysql-connector-java/8.0.28/mysql-connector-java-8.0.28.jar

COPY /dependency/streampark-${STREAMPARK_VERSION}/config.yaml /usr/local/apache-streampark_2.12-${STREAMPARK_VERSION}-bin/conf/

RUN echo "export STREAMPARK_HOME=/usr/local/apache-streampark_2.12-${STREAMPARK_VERSION}-bin" >> /etc/profile && \
    echo 'export PATH=${PATH}:${STREAMPARK_HOME}/bin' >> /etc/profile && \
    dos2unix /usr/local/apache-streampark_2.12-${STREAMPARK_VERSION}-bin/* && \
    mkdir -p /tmp/streampark

ENV STREAMPARK_HOME /usr/local/apache-streampark_2.12-${STREAMPARK_VERSION}-bin
ENV PATH ${PATH}:${STREAMPARK_HOME}/bin

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
     echo 'source /etc/profile' >> /usr/local/bin/enterpoint.sh && \
    echo 'while [[ `echo -e '"'"'\\n'"'"' | telnet mysql 3306 2>/dev/null | grep Connected | wc -l` -eq 0 ]]' >> /usr/local/bin/enterpoint.sh && \
    echo 'do' >> /usr/local/bin/enterpoint.sh && \
    echo '  nohup echo "check mysql sleep ......" >> ${STREAMPARK_HOME}/logs/sleep.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo '  sleep 1s' >> /usr/local/bin/enterpoint.sh && \
    echo 'done' >> /usr/local/bin/enterpoint.sh && \
    echo 'while [[ `echo -e '"'"'\\n'"'"' | telnet hadoop 8020 2>/dev/null | grep Connected | wc -l` -eq 0 ]]' >> /usr/local/bin/enterpoint.sh && \
    echo 'do' >> /usr/local/bin/enterpoint.sh && \
    echo '  nohup echo "check hadoop sleep ......" >> ${STREAMPARK_HOME}/logs/sleep.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo '  sleep 1s' >> /usr/local/bin/enterpoint.sh && \
    echo 'done' >> /usr/local/bin/enterpoint.sh && \
    echo 'mysql -hmysql -uroot -proot < ${STREAMPARK_HOME}/script/schema/mysql-schema.sql' >> /usr/local/bin/enterpoint.sh && \
    echo 'mysql -hmysql -uroot -proot < ${STREAMPARK_HOME}/script/data/mysql-data.sql' >> /usr/local/bin/enterpoint.sh && \
    echo 'hdfs dfs -mkdir -f /streampark' >> /usr/local/bin/enterpoint.sh && \
    echo 'startup.sh' >> /usr/local/bin/enterpoint.sh && \
    echo 'sleep infinity' >> /usr/local/bin/enterpoint.sh