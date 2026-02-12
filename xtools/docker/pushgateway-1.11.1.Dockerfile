FROM 10.10.52.13:5000/lakehouse/ubuntu:20.04.b

ARG PUSHGATEWAY_VERSION="1.11.1"

RUN wget -P /usr/local/src/ https://github.com/prometheus/pushgateway/releases/download/v${PUSHGATEWAY_VERSION}/pushgateway-${PUSHGATEWAY_VERSION}.linux-amd64.tar.gz && \
    tar zxvf /usr/local/src/pushgateway-${PUSHGATEWAY_VERSION}.linux-amd64.tar.gz -C /usr/local/ && \
    rm -rf /usr/local/src/pushgateway-${PUSHGATEWAY_VERSION}.linux-amd64.tar.gz

RUN echo "export PUSHGATEWAY_HOME=/usr/local/pushgateway-${PUSHGATEWAY_VERSION}.linux-amd64" >> /etc/profile && \
    echo 'export PATH=${PATH}:${PUSHGATEWAY_HOME}' >> /etc/profile && \
    mkdir -p /usr/local/pushgateway-${PUSHGATEWAY_VERSION}.linux-amd64/logs

ENV PUSHGATEWAY_HOME /usr/local/pushgateway-${PUSHGATEWAY_HOME}.linux-amd64
ENV PATH ${PATH}:${PUSHGATEWAY_HOME}

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo 'source /etc/profile' >> /usr/local/bin/enterpoint.sh && \
    echo 'nohup pushgateway --web.listen-address="0.0.0.0:9091" > /usr/local/pushgateway-${PUSHGATEWAY_VERSION}.linux-amd64/logs/prometheus-start.log  2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo 'tail -f /root/.bashrc' >> /usr/local/bin/enterpoint.sh

ENTRYPOINT ["/bin/bash", "/usr/local/bin/enterpoint.sh"]