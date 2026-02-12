FROM 10.10.52.13:5000/lakehouse/ubuntu:20.04.p

ARG HARBOR_VERSION="2.10.3"

RUN wget -P /usr/local/src/ https://github.com/goharbor/harbor/releases/download/v${HARBOR_VERSION}/harbor-offline-installer-v${HARBOR_VERSION}.tgz && \
    tar zxvf /usr/local/src/harbor-offline-installer-v${HARBOR_VERSION}.tgz -C /usr/local/ && \
    rm -rf /usr/local/src/harbor-offline-installer-v${HARBOR_VERSION}.tgz

RUN apt-get update && \
    apt-get install -y ca-certificates curl gnupg lsb-release && \
    curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | apt-key add - && \
    sh -c 'echo "deb [arch=amd64] https://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list' && \
    apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io && \
    apt-get clean

COPY /dependency/harbor-${HARBOR_VERSION}/harbor.yml /usr/local/src/harbor/
COPY /dependency/harbor-${HARBOR_VERSION}/daemon.json /etc/docker/
COPY /dependency/harbor-${HARBOR_VERSION}/docker-compose /usr/bin/
COPY /dependency/harbor-${HARBOR_VERSION}/enterpoint.sh /usr/local/bin/

RUN chmod 755 /usr/local/bin/enterpoint.sh

CMD ["/usr/local/bin/enterpoint.sh"]