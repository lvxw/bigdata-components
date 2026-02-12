FROM 10.10.52.13:5000/lakehouse/ubuntu:20.04.j

ARG PULSAR_MANAGER_VERSION="0.3.0"

RUN wget -P /usr/local/src/ https://archive.apache.org/dist/pulsar/pulsar-manager-${PULSAR_MANAGER_VERSION}/apache-pulsar-manager-${PULSAR_MANAGER_VERSION}-bin.tar.gz && \
    tar zxvf /usr/local/src/apache-pulsar-manager-${PULSAR_MANAGER_VERSION}-bin.tar.gz -C /usr/local/ && \
    rm -rf /usr/local/src/apache-pulsar-manager-${PULSAR_MANAGER_VERSION}-bin.tar.gz

RUN cd /usr/local/pulsar-manager && \
    tar -xvf pulsar-manager.tar && \
    cd pulsar-manager && \
    cp -r ../dist ui

RUN echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /etc/profile

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV PATH ${PATH}:${JAVA_HOME}/bin

RUN echo '#!/bin/bash' > /usr/local/bin/enterpoint.sh && \
    echo 'cd /usr/local/pulsar-manager/pulsar-manager && nohup ./bin/pulsar-manager > /dev/null 2>&1 &' >> /usr/local/bin/enterpoint.sh && \
    echo 'sleep 20s' >> /usr/local/bin/enterpoint.sh && \
    echo 'CSRF_TOKEN=$(curl http://pulsar-manager:7750/pulsar-manager/csrf-token)' >> /usr/local/bin/enterpoint.sh && \
    echo 'curl \
      -H "X-XSRF-TOKEN: $CSRF_TOKEN" \
      -H "Cookie: XSRF-TOKEN=$CSRF_TOKEN;" \
      -H "Content-Type: application/json" \
      -X PUT http://pulsar-manager:7750/pulsar-manager/users/superuser \
      -d '\''{"name": "admin", "password": "123456", "description": "pulsar-manager", "email": "admin@qq.com"}'\''' >> /usr/local/bin/enterpoint.sh && \
    echo 'tail -f /root/.bashrc' >> /usr/local/bin/enterpoint.sh

ENTRYPOINT ["/bin/bash", "/usr/local/bin/enterpoint.sh"]
