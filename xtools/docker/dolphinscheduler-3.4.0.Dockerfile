FROM 10.10.52.13:5000/lakehouse/spark:3.5.4

ARG DOLPHINSCHEDULER_VERSION="3.4.0"

RUN wget -P /usr/local/src/ https://archive.apache.org/dist/dolphinscheduler/${DOLPHINSCHEDULER_VERSION}/apache-dolphinscheduler-${DOLPHINSCHEDULER_VERSION}-bin.tar.gz && \
    tar zxvf /usr/local/src/apache-dolphinscheduler-${DOLPHINSCHEDULER_VERSION}-bin.tar.gz -C /usr/local/ && \
    rm -rf /usr/local/src/apache-dolphinscheduler-${DOLPHINSCHEDULER_VERSION}-bin.tar.gz

RUN wget -P /usr/local/apache-dolphinscheduler-${DOLPHINSCHEDULER_VERSION}-bin/api-server/libs/ https://repo.maven.apache.org/maven2/mysql/mysql-connector-java/8.0.28/mysql-connector-java-8.0.28.jar && \
    wget -P /usr/local/dolphinscheduler-${DOLPHINSCHEDULER_VERSION}-bin/plugins/storage-plugins/ https://repo.maven.apache.org/maven2/org/apache/dolphinscheduler/dolphinscheduler-storage-hdfs/${DOLPHINSCHEDULER_VERSION}/dolphinscheduler-storage-hdfs-${DOLPHINSCHEDULER_VERSION}.jar && \
    wget -P /usr/local/dolphinscheduler-${DOLPHINSCHEDULER_VERSION}-bin/plugins/task-plugins https://repo.maven.apache.org/maven2/org/apache/dolphinscheduler/dolphinscheduler-task-shell/${DOLPHINSCHEDULER_VERSION}/dolphinscheduler-task-shell-${DOLPHINSCHEDULER_VERSION}.jar  && \
    cp /usr/local/apache-dolphinscheduler-${DOLPHINSCHEDULER_VERSION}-bin/api-server/libs/mysql-connector-java-8.0.28.jar /usr/local/apache-dolphinscheduler-${DOLPHINSCHEDULER_VERSION}-bin/alert-server/libs/ && \
    cp /usr/local/apache-dolphinscheduler-${DOLPHINSCHEDULER_VERSION}-bin/api-server/libs/mysql-connector-java-8.0.28.jar /usr/local/apache-dolphinscheduler-${DOLPHINSCHEDULER_VERSION}-bin/master-server/libs/ && \
    cp /usr/local/apache-dolphinscheduler-${DOLPHINSCHEDULER_VERSION}-bin/api-server/libs/mysql-connector-java-8.0.28.jar /usr/local/apache-dolphinscheduler-${DOLPHINSCHEDULER_VERSION}-bin/worker-server/libs/ && \
    cp /usr/local/apache-dolphinscheduler-${DOLPHINSCHEDULER_VERSION}-bin/api-server/libs/mysql-connector-java-8.0.28.jar /usr/local/apache-dolphinscheduler-${DOLPHINSCHEDULER_VERSION}-bin/tools/libs/ && \
    mkdir -p /usr/local/apache-dolphinscheduler-${DOLPHINSCHEDULER_VERSION}-bin/plugins/storage-plugins /usr/local/apache-dolphinscheduler-${DOLPHINSCHEDULER_VERSION}-bin/plugins/task-plugins

RUN echo "export DOLPHINSCHEDULER_HOME=/usr/local/apache-dolphinscheduler-${DOLPHINSCHEDULER_VERSION}-bin" >> /etc/profile && \
    echo 'export PATH=${PATH}:${DOLPHINSCHEDULER_HOME}/bin' >> /etc/profile && \
    mkdir -p /usr/local/apache-dolphinscheduler-${DOLPHINSCHEDULER_VERSION}-bin/standalone-server/logs

ENV DOLPHINSCHEDULER_HOME /usr/local/apache-dolphinscheduler-${DOLPHINSCHEDULER_VERSION}-bin
ENV PATH ${PATH}:${DOLPHINSCHEDULER_HOME}/bin

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo ' ' >> /usr/local/bin/enterpoint.sh && \
    echo 'while [[ `echo -e '"'"'\\n'"'"' | telnet mysql 3306 2>/dev/null | grep Connected | wc -l` -eq 0 ]]' >> /usr/local/bin/enterpoint.sh && \
    echo 'do' >> /usr/local/bin/enterpoint.sh && \
    echo '  nohup echo "check mysql sleep ......" >> ${DOLPHINSCHEDULER_HOME}/standalone-server/logs/sleep.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo '  sleep 1s' >> /usr/local/bin/enterpoint.sh && \
    echo 'done' >> /usr/local/bin/enterpoint.sh && \
    echo 'mysql -hmysql -uroot -proot -e "drop database if exists dolphinscheduler;"' >> /usr/local/bin/enterpoint.sh && \
    echo 'mysql -hmysql -uroot -proot -e "create database if not exists dolphinscheduler;"' >> /usr/local/bin/enterpoint.sh && \
    echo 'mysql -hmysql -uroot -proot -Ddolphinscheduler < ${DOLPHINSCHEDULER_HOME}/standalone-server/sql/dolphinscheduler_mysql.sql' >> /usr/local/bin/enterpoint.sh && \
    echo 'mysql -hmysql -uroot -proot -e "update dolphinscheduler.t_ds_user set user_password='"'"'21232f297a57a5a743894a0e4a801fc3'"'"' where user_name='"'"'admin'"'"';"' >> /usr/local/bin/enterpoint.sh && \
    echo 'export SPRING_PROFILES_ACTIVE=mysql' >> /usr/local/bin/enterpoint.sh && \
    echo 'export SPRING_DATASOURCE_URL="jdbc:mysql://mysql:3306/dolphinscheduler?useUnicode=true&characterEncoding=UTF-8&useSSL=false"' >> /usr/local/bin/enterpoint.sh && \
    echo 'export SPRING_DATASOURCE_USERNAME=root' >> /usr/local/bin/enterpoint.sh && \
    echo 'export SPRING_DATASOURCE_PASSWORD=root' >> /usr/local/bin/enterpoint.sh && \
    echo 'dolphinscheduler-daemon.sh start standalone-server' >> /usr/local/bin/enterpoint.sh && \
    echo 'sleep infinity' >> /usr/local/bin/enterpoint.sh
