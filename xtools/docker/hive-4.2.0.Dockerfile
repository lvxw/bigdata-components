FROM 10.10.52.13:5000/lakehouse/hadoop:3.4.3

ARG HIVE_VERSION=4.2.0
ARG PAIMON_VERSION="1.3.1"

RUN wget -P /usr/local/src/ https://archive.apache.org/dist/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz && \
    tar zxvf /usr/local/src/apache-hive-${HIVE_VERSION}-bin.tar.gz -C /usr/local/ && \
    rm -rf /usr/local/src/apache-hive-${HIVE_VERSION}-bin.tar.gz

COPY /dependency/hive-${HIVE_VERSION}/hive-site.xml /usr/local/apache-hive-${HIVE_VERSION}-bin/conf/
COPY /dependency/hive-${HIVE_VERSION}/hive-env.sh /usr/local/apache-hive-${HIVE_VERSION}-bin/conf/
COPY /dependency/hive-${HIVE_VERSION}/enter-beeline.sh /usr/local/bin/
RUN wget -P /usr/local/apache-hive-${HIVE_VERSION}-bin/lib/ https://repo.maven.apache.org/maven2/mysql/mysql-connector-java/8.0.28/mysql-connector-java-8.0.28.jar
RUN wget -P /usr/local/apache-hive-${HIVE_VERSION}-bin/lib/ https://repo.maven.apache.org/maven2/org/apache/paimon/paimon-hive-connector-3.1/${PAIMON_VERSION}/paimon-hive-connector-3.1-${PAIMON_VERSION}.jar

RUN echo "export HIVE_HOME=/usr/local/apache-hive-${HIVE_VERSION}-bin" >> /etc/profile && \
    echo 'export PATH=${PATH}:${HIVE_HOME}/bin' >> /etc/profile && \
    dos2unix /usr/local/bin/enter-beeline.sh /usr/local/apache-hive-${HIVE_VERSION}-bin/conf/hive-env.sh && \
    chmod 755 /usr/local/bin/enter-beeline.sh && \
    mkdir -p /usr/local/apache-hive-${HIVE_VERSION}-bin/logs /usr/local/apache-hive-${HIVE_VERSION}-bin/tmp/root /usr/local/apache-hive-${HIVE_VERSION}-bin/aux_jars
ENV HIVE_HOME /usr/local/apache-hive-${HIVE_VERSION}-bin
ENV PATH ${PATH}:${HIVE_HOME}/bin

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo 'while [[ `echo -e '"'"'\\n'"'"' | telnet hadoop 8020 2>/dev/null | grep Connected | wc -l` -eq 0 ]]' >> /usr/local/bin/enterpoint.sh && \
    echo 'do' >> /usr/local/bin/enterpoint.sh && \
    echo '  nohup echo "check hadoop sleep ......" >> ${HIVE_HOME}/logs/sleep.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo '  sleep 1s' >> /usr/local/bin/enterpoint.sh && \
    echo 'done' >> /usr/local/bin/enterpoint.sh && \
    echo 'while [[ `echo -e '"'"'\\n'"'"' | telnet mysql 3306 2>/dev/null | grep Connected | wc -l` -eq 0 ]]' >> /usr/local/bin/enterpoint.sh && \
    echo 'do' >> /usr/local/bin/enterpoint.sh && \
    echo '  nohup echo "check mysql sleep ......" >> ${HIVE_HOME}/logs/sleep.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo '  sleep 1s' >> /usr/local/bin/enterpoint.sh && \
    echo 'done' >> /usr/local/bin/enterpoint.sh && \
    echo 'source /etc/profile' >> /usr/local/bin/enterpoint.sh && \
    echo 'if [[ `mysql -N -L -hmysql  -uroot -proot -e "select count(*) from information_schema.SCHEMATA where SCHEMA_NAME = '"'"'hive'"'"';"` -eq 0 ]]' >> /usr/local/bin/enterpoint.sh && \
    echo 'then' >> /usr/local/bin/enterpoint.sh && \
    echo '  while [[ `echo -e '"'"'\\n'"'"' | telnet zookeeper 2181 2>/dev/null | grep Connected | wc -l` -eq 0 ]]' >> /usr/local/bin/enterpoint.sh && \
    echo '  do' >> /usr/local/bin/enterpoint.sh && \
    echo '    nohup echo "check zookeeper sleep ......" >> ${HIVE_HOME}/logs/sleep.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo '    sleep 1s' >> /usr/local/bin/enterpoint.sh && \
    echo '  done' >> /usr/local/bin/enterpoint.sh && \
    echo 'schematool -dbType mysql -initSchema --verbose > ${HIVE_HOME}/logs/initSchema.log  2>&1' >> /usr/local/bin/enterpoint.sh && \
    echo 'fi' >> /usr/local/bin/enterpoint.sh && \
    echo 'nohup hive --service metastore > ${HIVE_HOME}/logs/hivemetastore.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo 'while [[ `echo -e '"'"'\\n'"'"' | telnet hive 9083 2>/dev/null | grep Connected | wc -l` -eq 0 ]]' >> /usr/local/bin/enterpoint.sh && \
    echo 'do' >> /usr/local/bin/enterpoint.sh && \
    echo '  nohup echo "check hive metastore sleep ......" >> ${HIVE_HOME}/logs/sleep.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo '  sleep 1s' >> /usr/local/bin/enterpoint.sh && \
    echo 'done' >> /usr/local/bin/enterpoint.sh && \
    echo 'nohup hive --service hiveserver2 > ${HIVE_HOME}/logs/hiveserver2.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo 'sleep infinity' >> /usr/local/bin/enterpoint.sh
