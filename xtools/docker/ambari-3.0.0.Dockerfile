FROM 10.10.52.13:5000/lakehouse/docker:28.1.1

ARG AMBARI_VERSION=3.0.0

RUN echo 'dke() {' >> /etc/profile && \
    echo 'docker exec -it "$1" /bin/bash' >> /etc/profile && \
    echo '}' >> /etc/profile && \
    echo '{"storage-driver": "vfs"}'> /etc/docker/daemon.json && \
    wget -O /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/v2.29.4/docker-compose-linux-x86_64 && \
    chmod 755 /usr/local/bin/docker-compose && \
    mkdir -p /usr/local/src/ambari-repo  /usr/local/src/conf

COPY /dependency/ambari-${AMBARI_VERSION}/hosts /usr/local/src/conf/
COPY /dependency/ambari-${AMBARI_VERSION}/docker-compose.yml /usr/local/src/


RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo 'docker-compose up -d' >> /usr/local/bin/enterpoint.sh && \
    echo 'docker exec -it bigtop_hostname0 yum install net-tools openssh-clients openssh-server -y' >> /usr/local/bin/enterpoint.sh && \
    echo 'docker exec -it bigtop_hostname1 yum install net-tools openssh-clients openssh-server -y' >> /usr/local/bin/enterpoint.sh && \
    echo 'docker exec -it bigtop_hostname2 yum install net-tools openssh-clients openssh-server -y' >> /usr/local/bin/enterpoint.sh && \
    echo 'docker exec -it bigtop_hostname3 yum install net-tools openssh-clients openssh-server -y' >> /usr/local/bin/enterpoint.sh && \
    echo 'sleep infinity' >> /usr/local/bin/enterpoint.sh && \
    chmod 755 /usr/local/bin/enterpoint.sh

WORKDIR /usr/local/src/