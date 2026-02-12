FROM 10.10.52.13:5000/lakehouse/ubuntu:20.04.j

ARG ELASTICSEARCH_VERSION="7.14.2"

RUN wget -P /usr/local/src/ https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.14.2-linux-x86_64.tar.gz && \
    tar zxvf /usr/local/src/elasticsearch-${ELASTICSEARCH_VERSION}-linux-x86_64.tar.gz -C /usr/local/ && \
    rm -rf /usr/local/src/elasticsearch-${ELASTICSEARCH_VERSION}-linux-x86_64.tar.gz

COPY /dependency/elasticsearch-${ELASTICSEARCH_VERSION}/elasticsearch.yml /usr/local/elasticsearch-${ELASTICSEARCH_VERSION}/config/

RUN echo "export ELASTICSEARCH_HOME=/usr/local/elasticsearch-${ELASTICSEARCH_VERSION}" >> /etc/profile && \
    echo 'export PATH=${PATH}:${ELASTICSEARCH_HOME}/bin' >> /etc/profile && \
    groupadd es && \
    useradd es -g es && \
    chown -R es:es /usr/local/elasticsearch-${ELASTICSEARCH_VERSION} && \
    echo 'vm.max_map_count=262144' >> /etc/sysctl.conf && \
    sysctl -p

ENV ELASTICSEARCH_HOME /usr/local/elasticsearch-${ELASTICSEARCH_VERSION}
ENV PATH ${PATH}:${ELASTICSEARCH_HOME}/bin

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo 'su - es <<EOF' >> /usr/local/bin/enterpoint.sh && \
    echo 'elasticsearch -d' >> /usr/local/bin/enterpoint.sh && \
    echo 'EOF' >> /usr/local/bin/enterpoint.sh && \
    echo 'sleep infinity' >> /usr/local/bin/enterpoint.sh

ENTRYPOINT ["/bin/bash", "/usr/local/bin/enterpoint.sh"]