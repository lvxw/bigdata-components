FROM 10.10.52.13:5000/lakehouse/ubuntu:20.04.j

RUN apt-get update && \
    apt-get -y install mysql-client && \
    apt-get clean

ARG DORIS_VERSION="2.1.11"

RUN wget -P /usr/local/src/ https://apache-doris-releases.oss-accelerate.aliyuncs.com/apache-doris-${DORIS_VERSION}-bin-x64.tar.gz && \
    tar zxvf /usr/local/src/apache-doris-${DORIS_VERSION}-bin-x64.tar.gz -C /usr/local/ && \
    rm -rf /usr/local/src/apache-doris-${DORIS_VERSION}-bin-x64.tar.gz

COPY /dependency/doris-${DORIS_VERSION}/fe.conf /usr/local/apache-doris-${DORIS_VERSION}-bin-x64/fe/conf/
COPY /dependency/doris-${DORIS_VERSION}/init.sql /usr/local/apache-doris-${DORIS_VERSION}-bin-x64/fe/conf/
COPY /dependency/doris-${DORIS_VERSION}/be.conf /usr/local/apache-doris-${DORIS_VERSION}-bin-x64/be/conf/
COPY /dependency/doris-${DORIS_VERSION}/enter-sql-client.sh /usr/local/bin/

RUN dos2unix /usr/local/apache-doris-${DORIS_VERSION}-bin-x64/fe/conf/* /usr/local/apache-doris-${DORIS_VERSION}-bin-x64/be/conf/* && \
    mkdir -p /usr/local/apache-doris-${DORIS_VERSION}-bin-x64/logs && \
    echo "* soft nofile 204800" >> /etc/security/limits.conf && \
    echo "* hard nofile 204800" >> /etc/security/limits.conf && \
    echo "* soft nproc 204800" >> /etc/security/limits.conf && \
    echo "* hard nproc 204800" >> /etc/security/limits.conf && \
    echo "fs.file-max = 6553560" >> /etc/sysctl.conf && \
    echo "vm.max_map_count = 2000000" >> /etc/sysctl.conf && \
    echo "fs.inotify.max_user_instances = 6553560" >> /etc/sysctl.conf && \
    echo "fs.inotify.max_user_watches = 6553560" >> /etc/sysctl.conf && \
    sysctl -p && \
    echo "export DORIS_HOME=/usr/local/apache-doris-${DORIS_VERSION}-bin-x64" >> /etc/profile && \
    echo 'export PATH=${PATH}:${DORIS_HOME}/fe/bin:${DORIS_HOME}/be/bin' >> /etc/profile && \
    chmod 755 /usr/local/bin/*.sh

ENV DORIS_HOME /usr/local/apache-doris-${DORIS_VERSION}-bin-x64
ENV PATH ${PATH}:${DORIS_HOME}/fe/bin:${DORIS_HOME}/be/bin

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo 'source /etc/profile' >> /usr/local/bin/enterpoint.sh && \
    echo 'swapoff -a' >> /usr/local/bin/enterpoint.sh && \
    echo 'sysctl -w vm.max_map_count=2000000' >> /usr/local/bin/enterpoint.sh && \
    echo 'ip_addr=`ip addr  |  grep eth0 |  grep 'inet' | awk '"'"'{print $2}'"'"'`' >> /usr/local/bin/enterpoint.sh && \
    echo 'echo "priority_networks = ${ip_addr}" >> ${DORIS_HOME}/fe/conf/fe.conf' >> /usr/local/bin/enterpoint.sh && \
    echo 'echo "priority_networks = ${ip_addr}" >> ${DORIS_HOME}/be/conf/be.conf' >> /usr/local/bin/enterpoint.sh && \
    echo 'cd ${DORIS_HOME}' >> /usr/local/bin/enterpoint.sh && \
    echo './fe/bin/start_fe.sh --daemon' >> /usr/local/bin/enterpoint.sh && \
    echo './be/bin/start_be.sh --daemon' >> /usr/local/bin/enterpoint.sh && \
    echo 'while [[ `echo -e '"'"'\\n'"'"' | telnet doris 49030 2>/dev/null | grep Connected | wc -l` -eq 0 ]]' >> /usr/local/bin/enterpoint.sh && \
    echo 'do' >> /usr/local/bin/enterpoint.sh && \
    echo '  echo "check doris fe sleep ......" >> ${DORIS_HOME}/logs/sleep.log' >> /usr/local/bin/enterpoint.sh && \
    echo '  sleep 1s' >> /usr/local/bin/enterpoint.sh && \
    echo 'done' >> /usr/local/bin/enterpoint.sh && \
    echo 'mysql --ssl-mode=DISABLE -uroot -P49030 -hdoris -e '"'"'ALTER SYSTEM ADD BACKEND "doris:49050";'"'"'' >> /usr/local/bin/enterpoint.sh && \
    echo 'mysql --ssl-mode=DISABLE -uroot -P49030 -hdoris -e "create user '"'"'doris'"'"' identified by '"'"'doris'"'"';"' >> /usr/local/bin/enterpoint.sh && \
    echo 'mysql --ssl-mode=DISABLE -uroot -P49030 -hdoris -e "GRANT ADMIN_PRIV ON *.*.* TO '"'"'doris'"'"'@'"'"'%'"'"';"' >> /usr/local/bin/enterpoint.sh && \
    echo 'mysql --ssl-mode=DISABLE -uroot -P49030 -hdoris -e "SET global  time_zone = '"'"'Asia/Shanghai'"'"'"' >> /usr/local/bin/enterpoint.sh && \
    echo 'mysql --ssl-mode=DISABLE -uroot -P49030 -hdoris -e "SET PASSWORD FOR '"'"'root'"'"' = PASSWORD('"'"'root'"'"');"' >> /usr/local/bin/enterpoint.sh && \
    echo 'while [[ `echo -e '"'"'\\n'"'"' | telnet doris 48040 2>/dev/null | grep Connected | wc -l` -eq 0 ]]' >> /usr/local/bin/enterpoint.sh && \
    echo 'do' >> /usr/local/bin/enterpoint.sh && \
    echo '  echo "check doris be sleep ......" >> ${DORIS_HOME}/logs/sleep.log' >> /usr/local/bin/enterpoint.sh && \
    echo '  sleep 1s' >> /usr/local/bin/enterpoint.sh && \
    echo 'done' >> /usr/local/bin/enterpoint.sh && \
    echo 'sleep 10s' >> /usr/local/bin/enterpoint.sh && \
    echo 'mysql --ssl-mode=DISABLE -uroot -proot -P49030 -hdoris < ${DORIS_HOME}/fe/conf/init.sql' >> /usr/local/bin/enterpoint.sh && \
    echo 'sleep infinity' >> /usr/local/bin/enterpoint.sh

ENTRYPOINT ["/bin/bash", "/usr/local/bin/enterpoint.sh"]