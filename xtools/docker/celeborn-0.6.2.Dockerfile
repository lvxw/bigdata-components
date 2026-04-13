FROM 10.10.52.13:5000/lakehouse/ubuntu:24.04.j

ARG CELEBORN_VERSION="0.6.2"

RUN wget -P /usr/local/src/ https://archive.apache.org/dist/celeborn/celeborn-${CELEBORN_VERSION}/apache-celeborn-${CELEBORN_VERSION}-bin.tgz && \
    tar zxvf /usr/local/src/apache-celeborn-${CELEBORN_VERSION}-bin.tgz -C /usr/local/ && \
    rm -rf /usr/local/src/apache-celeborn-${CELEBORN_VERSION}-bin.tgz

COPY /dependency/celeborn-${CELEBORN_VERSION}/celeborn-defaults.conf /usr/local/apache-celeborn-${CELEBORN_VERSION}-bin/conf/

RUN echo "export CELEBORN_HOME=/usr/local/apache-celeborn-${CELEBORN_VERSION}-bin" >> /etc/profile && \
    echo "celeborn.worker.storage.dirs=/usr/local/apache-celeborn-${CELEBORN_VERSION}-bin/shuffle" >> /usr/local/apache-celeborn-${CELEBORN_VERSION}-bin/conf/celeborn-defaults.conf && \
    echo 'export PATH=${PATH}:${CELEBORN_HOME}/bin:${CELEBORN_HOME}/sbin' >> /etc/profile

ENV CELEBORN_HOME /usr/local/apache-celeborn-${CELEBORN_VERSION}-bin
ENV PATH ${PATH}:${CELEBORN_HOME}/bin:${CELEBORN_HOME}/sbin

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo '' >> /usr/local/bin/enterpoint.sh && \
    echo 'source /etc/profile' >> /usr/local/bin/enterpoint.sh && \
    echo 'start-master.sh' >> /usr/local/bin/enterpoint.sh && \
    echo 'start-worker.sh' >> /usr/local/bin/enterpoint.sh && \
    echo 'sleep infinity' >> /usr/local/bin/enterpoint.sh

ENTRYPOINT ["/bin/bash", "/usr/local/bin/enterpoint.sh"]