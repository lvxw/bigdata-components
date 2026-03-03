FROM 10.10.52.13:5000/lakehouse/ubuntu:20.04.p

RUN apt update && \
    apt install -y software-properties-common && \
    wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null && \
    apt-add-repository "deb https://apt.kitware.com/ubuntu/ $(lsb_release -cs) main" && \
    apt-get update && \
    apt-get install -y git cmake && \
    apt-get clean

ARG NODEJS_VERSION="24.14.0"

RUN wget -P /usr/local/src/ https://nodejs.org/dist/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}-linux-x64.tar.xz && \
    tar -xvf /usr/local/src/node-v${NODEJS_VERSION}-linux-x64.tar.xz -C /usr/local/ && \
    rm -rf /usr/local/src/node-v${NODEJS_VERSION}-linux-x64.tar.xz && \
    echo "export NODEJS_HOME=/usr/local/node-v${NODEJS_VERSION}-linux-x64" >> /etc/profile && \
    echo 'export PATH=${PATH}:${NODEJS_HOME}/bin' >> /etc/profile

ENV NODEJS_HOME /usr/local/node-v${NODEJS_VERSION}-linux-x64
ENV PATH ${PATH}:${NODEJS_HOME}/bin

RUN npm install -g openclaw@2026.3.1

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo "source /etc/profile" >> /usr/local/bin/enterpoint.sh && \
    echo "openclaw onboard --install-daemon" >> /usr/local/bin/enterpoint.sh && \
    echo 'sleep infinity' >> /usr/local/bin/enterpoint.sh \


ENTRYPOINT ["/bin/bash", "/usr/local/bin/enterpoint.sh"]
