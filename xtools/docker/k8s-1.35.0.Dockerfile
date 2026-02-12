FROM 10.10.52.13:5000/lakehouse/docker:28.1.1

USER root

ENV LANG C.UTF-8

COPY /dependency/k8s-1.35.0/kind-cluster-config.yaml /usr/local/src/
COPY  /dependency/k8s-1.35.0/kind.service /etc/systemd/system/

RUN apt-get update && \
    apt-get -y install vim dos2unix net-tools iputils-ping telnet rsync wget tree netcat curl zip unzip tree openssh-server iproute2 less lsof cron podman && \
    apt-get clean && \
    rm -rf /etc/localtime && \
    ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN curl -Lo /usr/local/bin/kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    curl -Lo /usr/local/bin/kind https://kind.sigs.k8s.io/dl/v0.31.0/kind-linux-amd64 && \
    chmod 755 /usr/local/bin/* && \
    mkdir -p /lib/modules && \
    echo "export KIND_EXPERIMENTAL_PROVIDER=podman" >> /etc/profile && \
    mkdir -p /etc/systemd/system/multi-user.target.wants/ && \
    ln -sf /etc/systemd/system/kind.service /etc/systemd/system/multi-user.target.wants/kind.service && \
    echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo 'source /etc/profile' >> /usr/local/bin/enterpoint.sh && \
    echo 'kind create cluster --name podman-k8s-cluster --config /usr/local/src/kind-cluster-config.yaml  > /tmp/kind.log 2>&1' >> /usr/local/bin/enterpoint.sh && \
    echo 'sed -i 's/127.0.0.1/0.0.0.0/' ~/.kube/config' >> /usr/local/bin/enterpoint.sh && \
    echo 'sleep infinity' >> /usr/local/bin/enterpoint.sh && \
    chmod 755 /usr/local/bin/enterpoint.sh

ENV KIND_EXPERIMENTAL_PROVIDER podman

RUN podman pull docker.io/kindest/node:v1.35.0

CMD ["/usr/sbin/init"]