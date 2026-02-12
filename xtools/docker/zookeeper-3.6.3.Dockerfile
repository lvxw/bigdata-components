FROM docker.io/zookeeper:3.6.3

RUN rm -rf /etc/localtime && \
    ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime