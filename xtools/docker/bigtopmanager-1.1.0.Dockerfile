FROM 10.10.52.13:5000/lakehouse/docker:28.1.1

ARG GIGTOP_MANAGER=release-1.1.0
ARG MAVEN_VERSION=3.8.9

RUN apt-get update && \
    apt-get install -y git  openjdk-21-jdk && \
    apt-get clean

RUN git clone https://github.com/apache/bigtop-manager.git /usr/local/src/bigtop-manager && \
    cd /usr/local/src/bigtop-manager && \
    git switch -c ${GIGTOP_MANAGER} && \
    ./mvnw clean package -DskipTests && \
    echo '{"storage-driver": "vfs"}'> /etc/docker/daemon.json

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo 'cd /usr/local/src/bigtop-manager' >> /usr/local/bin/enterpoint.sh && \
    echo '#/bin/bash dev-support/docker/image/build.sh rocky-8' >> /usr/local/bin/enterpoint.sh && \
    echo '#/bin/bash dev-support/docker/containers/build.sh -e postgres -c 3 -o rocky-8 --skip-compile' >> /usr/local/bin/enterpoint.sh && \
    echo 'sleep infinity' >> /usr/local/bin/enterpoint.sh && \
    chmod 755 /usr/local/bin/enterpoint.sh