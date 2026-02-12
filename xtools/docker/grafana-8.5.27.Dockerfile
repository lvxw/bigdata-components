FROM 10.10.52.13:5000/lakehouse/ubuntu:20.04.p

RUN apt-get update && \
    apt-get -y install mysql-client && \
    apt-get clean

ARG GRAFANA_VERSION="8.5.27"

RUN wget -P /usr/local/src/ https://dl.grafana.com/oss/release/grafana-${GRAFANA_VERSION}.linux-amd64.tar.gz && \
    tar zxvf /usr/local/src/grafana-${GRAFANA_VERSION}.linux-amd64.tar.gz -C /usr/local/ && \
    rm -rf /usr/local/src/grafana-${GRAFANA_VERSION}.linux-amd64.tar.gz

COPY /dependency/grafana-${GRAFANA_VERSION}/defaults.ini /usr/local/grafana-${GRAFANA_VERSION}/conf/
COPY /dependency/grafana-${GRAFANA_VERSION}/init.sql /usr/local/grafana-${GRAFANA_VERSION}/conf/

RUN mkdir -p /usr/local/grafana-${GRAFANA_VERSION}/logs && \
    echo "export GRAFANA_HOME=/usr/local/grafana-${GRAFANA_VERSION}" >> /etc/profile && \
    echo 'export PATH=${PATH}:${GRAFANA_HOME}/bin' >> /etc/profile

ENV GRAFANA_HOME /usr/local/grafana-${GRAFANA_VERSION}
ENV PATH ${PATH}:${GRAFANA_HOME}/bin

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo "source /etc/profile" >> /usr/local/bin/enterpoint.sh && \
    echo 'while [[ `mysql -hmysql -uroot -proot -e "SELECT 1" > /dev/null 2>&1; echo $?` -ne 0 ]]' >> /usr/local/bin/enterpoint.sh && \
    echo 'do' >> /usr/local/bin/enterpoint.sh && \
    echo '  nohup echo "check mysql sleep ......" >> ${GRAFANA_HOME}/logs/sleep.log 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo '  sleep 1s' >> /usr/local/bin/enterpoint.sh && \
    echo 'done' >> /usr/local/bin/enterpoint.sh && \
    echo 'mysql -hmysql -uroot -proot -e "create database if not exists grafana;"' >> /usr/local/bin/enterpoint.sh && \
    echo 'mysql -hmysql -uroot -proot -Dgrafana < ${GRAFANA_HOME}/conf/init.sql' >> /usr/local/bin/enterpoint.sh && \
    echo 'cd ${GRAFANA_HOME}/ && nohup bin/grafana-server web > ${GRAFANA_HOME}/logs/grafana-start.log  2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo 'sleep infinity' >> /usr/local/bin/enterpoint.sh

ENTRYPOINT ["/bin/bash", "/usr/local/bin/enterpoint.sh"]
