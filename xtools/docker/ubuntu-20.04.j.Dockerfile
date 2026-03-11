FROM 10.10.52.13:5000/lakehouse/ubuntu:20.04.b

RUN apt-get update && \
    apt-get -y install openjdk-8-jdk && \
    apt-get clean

RUN echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /etc/profile && \
    echo 'export PATH=${PATH}:${JAVA_HOME}/bin' >> /etc/profile

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV PATH ${PATH}:${JAVA_HOME}/bin
