FROM 10.10.52.13:5000/lakehouse/ubuntu:20.04.b

RUN apt-get install -y apt-transport-https ca-certificates curl software-properties-common && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" && \
    apt-get update && \
    apt-get install -y docker-ce=5:20.10.13~3-0~ubuntu-focal docker-ce-cli=5:20.10.13~3-0~ubuntu-focal  containerd.io=1.5.10-1 && \
    apt-get clean && \
    mkdir -p /etc/docker && \
    echo '{' > /etc/docker/daemon.json && \
    echo '  "exec-opts": ["native.cgroupdriver=systemd"],' >> /etc/docker/daemon.json && \
    echo '  "registry-mirrors": ["https://aoewjvel.mirror.aliyuncs.com"],' >> /etc/docker/daemon.json && \
    echo '  "insecure-registries": ["http://10.10.52.13:5000"]' >> /etc/docker/daemon.json && \
    echo '}' >> /etc/docker/daemon.json
