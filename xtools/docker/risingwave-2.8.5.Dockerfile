FROM docker.io/risingwavelabs/risingwave:v2.8.5

ENV LANG C.UTF-8

RUN apt-get update && \
    apt-get -y install  postgresql-client && \
    apt-get clean && \
    rm -rf /etc/localtime && \
    ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN echo '!#/bin/bash' >> /usr/local/bin/enter-risingwave.sh && \
    echo '' >> /usr/local/bin/enter-risingwave.sh && \
    echo 'psql -h localhost -p 4566 -d dev -U root' >> /usr/local/bin/enter-risingwave.sh && \
    chmod 755 /usr/local/bin/enter-risingwave.sh