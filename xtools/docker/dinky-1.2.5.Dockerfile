FROM 10.10.52.13:5000/lakehouse/flink:1.20.3

ARG FLINK_MAIN_VERSION="1.20"
ARG FLINK_VERSION="${FLINK_MAIN_VERSION}.3"
ARG DINKY_VERSION="1.2.5"
ARG HIVE_VERSION="3.1.3"


RUN wget -P /usr/local/src/ https://github.com/DataLinkDC/dinky/releases/download/v${DINKY_VERSION}/dinky-release-${FLINK_MAIN_VERSION}-${DINKY_VERSION}.tar.gz && \
    tar zxvf /usr/local/src/dinky-release-${FLINK_MAIN_VERSION}-${DINKY_VERSION}.tar.gz -C /usr/local/ && \
    rm -rf /usr/local/src/dinky-release-${FLINK_MAIN_VERSION}-${DINKY_VERSION}.tar.gz

RUN wget -P /usr/local/dinky-release-${FLINK_MAIN_VERSION}-${DINKY_VERSION}/lib/ https://repo.maven.apache.org/maven2/mysql/mysql-connector-java/8.0.28/mysql-connector-java-8.0.28.jar && \
    wget -P /usr/local/dinky-release-${FLINK_MAIN_VERSION}-${DINKY_VERSION}/lib/ https://repo.maven.apache.org/maven2/org/apache/commons/commons-lang3/3.8.1/commons-lang3-3.8.1.jar && \
    wget -P /usr/local/dinky-release-${FLINK_MAIN_VERSION}-${DINKY_VERSION}/extends/flink${FLINK_MAIN_VERSION}/ https://repo.maven.apache.org/maven2/com/google/protobuf/protobuf-java/3.21.12/protobuf-java-3.21.12.jar

COPY /dependency/dinky-${DINKY_VERSION}/dinky-mysql-extension.sql /usr/local/dinky-release-${FLINK_MAIN_VERSION}-${DINKY_VERSION}/sql/

RUN rm -rf /usr/local/dinky-release-${FLINK_MAIN_VERSION}-${DINKY_VERSION}/lib/commons-lang3-3.3.2.jar && \
    cp -r /usr/local/flink-${FLINK_VERSION}/lib/* /usr/local/dinky-release-${FLINK_MAIN_VERSION}-${DINKY_VERSION}/extends/flink${FLINK_MAIN_VERSION}/ && \
    rm -rf /usr/local/dinky-release-${FLINK_MAIN_VERSION}-${DINKY_VERSION}/extends/flink${FLINK_MAIN_VERSION}/fluss-fs-*.jar && \
    cp /usr/local/apache-hive-${HIVE_VERSION}-bin/lib/hive-jdbc-${HIVE_VERSION}.jar /usr/local/dinky-release-${FLINK_MAIN_VERSION}-${DINKY_VERSION}/lib/ && \
    cp /usr/local/apache-hive-${HIVE_VERSION}-bin/lib/hive-service-${HIVE_VERSION}.jar /usr/local/dinky-release-${FLINK_MAIN_VERSION}-${DINKY_VERSION}/lib/ && \
    sed -i 's/${DB_ACTIVE:h2}/mysql/g'  /usr/local/dinky-release-${FLINK_MAIN_VERSION}-${DINKY_VERSION}/config/application.yml && \
    sed -i 's/port: 8888/port: 8889/g'  /usr/local/dinky-release-${FLINK_MAIN_VERSION}-${DINKY_VERSION}/config/application.yml  && \
    sed -i 's/${MYSQL_ADDR:127.0.0.1:3306}/mysql:3306/g'  /usr/local/dinky-release-${FLINK_MAIN_VERSION}-${DINKY_VERSION}/config/application-mysql.yml && \
    sed -i 's/${MYSQL_DATABASE:dinky}/dinky/g'  /usr/local/dinky-release-${FLINK_MAIN_VERSION}-${DINKY_VERSION}/config/application-mysql.yml && \
    sed -i 's/${MYSQL_USERNAME:dinky}/root/g'  /usr/local/dinky-release-${FLINK_MAIN_VERSION}-${DINKY_VERSION}/config/application-mysql.yml && \
    sed -i 's/${MYSQL_PASSWORD:dinky}/root/g'  /usr/local/dinky-release-${FLINK_MAIN_VERSION}-${DINKY_VERSION}/config/application-mysql.yml && \
    echo "export DINKY_HOME=/usr/local/dinky-release-${FLINK_MAIN_VERSION}-${DINKY_VERSION}" >> /etc/profile && \
    echo 'export PATH=${PATH}:${DINKY_HOME}' >> /etc/profile

ENV DINKY_HOME /usr/local/dinky-release-${FLINK_MAIN_VERSION}-${DINKY_VERSION}
ENV PATH ${PATH}:${DINKY_HOME}

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo 'source /etc/profile' >> /usr/local/bin/enterpoint.sh && \
    echo 'mkdir -p ${DINKY_HOME}/logs' >> /usr/local/bin/enterpoint.sh && \
    echo 'while [[ `mysql -hmysql -uroot -proot -e "SELECT 1" > /dev/null 2>&1; echo $?` -ne 0 ]]' >> /usr/local/bin/enterpoint.sh && \
    echo 'do' >> /usr/local/bin/enterpoint.sh && \
    echo '  nohup echo "check mysql sleep ......" >> ${DINKY_HOME}/logs/sleep.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo '  sleep 1s' >> /usr/local/bin/enterpoint.sh && \
    echo 'done' >> /usr/local/bin/enterpoint.sh && \
    echo 'while [[ `echo -e '"'"'\\n'"'"' | telnet flink 10004 2>/dev/null | grep Connected | wc -l` -eq 0 ]]' >> /usr/local/bin/enterpoint.sh && \
    echo 'do' >> /usr/local/bin/enterpoint.sh && \
    echo '  nohup echo "check flink sleep ......" >> ${DINKY_HOME}/logs/sleep.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo '  sleep 1s' >> /usr/local/bin/enterpoint.sh && \
    echo 'done' >> /usr/local/bin/enterpoint.sh && \
    echo 'mysql -hmysql -uroot -proot -e "drop database if exists dinky;"' >> /usr/local/bin/enterpoint.sh && \
    echo 'mysql -hmysql -uroot -proot -e "create database if not exists dinky;"' >> /usr/local/bin/enterpoint.sh && \
    echo 'mysql -hmysql -uroot -proot -e "grant all privileges on dinky.* to '"'"'dinky'"'"'@'"'"'%'"'"' identified by '"'"'dinky'"'"' with grant option;"' >> /usr/local/bin/enterpoint.sh && \
    echo 'mysql -hmysql -uroot -proot -e "flush privileges;"' >> /usr/local/bin/enterpoint.sh && \
    echo 'mysql -hmysql -udinky -pdinky -Ddinky < ${DINKY_HOME}/sql/dinky-mysql.sql' >> /usr/local/bin/enterpoint.sh && \
    echo 'mysql -hmysql -udinky -pdinky -Ddinky < ${DINKY_HOME}/sql/dinky-mysql-extension.sql' >> /usr/local/bin/enterpoint.sh && \
    echo 'hdfs  dfs -rm -r  /flink /dinky /hive' >> /usr/local/bin/enterpoint.sh && \
    echo 'hdfs  dfs -mkdir -p  /flink /dinky /hive /dinky/app' >> /usr/local/bin/enterpoint.sh && \
    echo 'hdfs  dfs -put -f ${FLINK_HOME}/lib /flink/' >> /usr/local/bin/enterpoint.sh && \
    echo 'hdfs  dfs -put -f ${HIVE_HOME}/conf /hive/' >> /usr/local/bin/enterpoint.sh && \
    echo "hdfs  dfs -put -f ${DINKY_HOME}/jar/dinky-app-${FLINK_MAIN_VERSION}-${DINKY_VERSION}-jar-with-dependencies.jar /dinky/" >> /usr/local/bin/enterpoint.sh && \
    echo 'hdfs dfs -put -f ${FLINK_HOME}/examples/streaming/SocketWindowWordCount.jar /dinky/app/' >> /usr/local/bin/enterpoint.sh && \
    echo 'nohup nc  -lk 9000 > /dev/null  2>&1  &' >> /usr/local/bin/enterpoint.sh && \
    echo 'yarn application -list |   grep Dinky-YarnSession-Query |  awk '"'"'{print $1}'"'"' | xargs yarn application -kill' >> /usr/local/bin/enterpoint.sh && \
    echo 'webUi=`yarn-session.sh -nm Dinky-YarnSession-Query -Dexecution.checkpointing.interval=5s -d |  grep  '"'"'JobManager Web Interface'"'"' |  awk -F '"'"'//'"'"' '"'"'{print $2}'"'"'`' >> /usr/local/bin/enterpoint.sh && \
    echo 'insert_sql="INSERT INTO dinky_cluster VALUES (1,1,'"'"'Dinky-YarnSession-Query'"'"','"'"'Dinky-YarnSession-Query'"'"','"'"'yarn-session'"'"','"'"'${webUi}'"'"','"'"'${webUi}'"'"','"'"'1.19.1'"'"',1,NULL,0,NULL,NULL,1,'"'"'2024-07-05 18:52:06'"'"','"'"'2024-07-05 18:58:28'"'"',2,2);"' >> /usr/local/bin/enterpoint.sh && \
    echo 'mysql -hmysql -udinky -pdinky -Ddinky -e "${insert_sql}"' >> /usr/local/bin/enterpoint.sh && \
    echo "cd ${DINKY_HOME} && nohup ./bin/auto.sh start ${FLINK_MAIN_VERSION}" >> /usr/local/bin/enterpoint.sh && \
    echo 'sleep infinity' >> /usr/local/bin/enterpoint.sh