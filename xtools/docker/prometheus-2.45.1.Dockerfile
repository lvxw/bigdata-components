FROM 10.10.52.13:5000/lakehouse/ubuntu:20.04.b

ARG PROMETHEUS_VERSION="2.45.1"

RUN wget -P /usr/local/src/ https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz && \
    tar zxvf /usr/local/src/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz -C /usr/local/ && \
    rm -rf /usr/local/src/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz

COPY /dependency/prometheus-${PROMETHEUS_VERSION}/prometheus.yml /usr/local/prometheus-${PROMETHEUS_VERSION}.linux-amd64/

RUN echo "export PROMETHEUS_HOME=/usr/local/prometheus-${PROMETHEUS_VERSION}.linux-amd64/" >> /etc/profile && \
    echo 'export PATH=${PATH}:${PROMETHEUS_HOME}:${PUSHGATEWAY_HOME}' >> /etc/profile && \
    mkdir -p /usr/local/prometheus-${PROMETHEUS_VERSION}.linux-amd64/logs

ENV PROMETHEUS_HOME /usr/local/prometheus-${PROMETHEUS_VERSION}.linux-amd64
ENV PATH ${PATH}:${PROMETHEUS_HOME}

RUN mkdir -p ${PROMETHEUS_HOME}/logs ${PUSHGATEWAY_HOME}/logs && \
    echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo 'source /etc/profile' >> /usr/local/bin/enterpoint.sh && \
    echo 'nohup prometheus --config.file ${PROMETHEUS_HOME}/prometheus.yml > ${PROMETHEUS_HOME}/logs/prometheus-start.log  2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo 'tail -f /root/.bashrc' >> /usr/local/bin/enterpoint.sh


ENTRYPOINT ["/bin/bash", "/usr/local/bin/enterpoint.sh"]