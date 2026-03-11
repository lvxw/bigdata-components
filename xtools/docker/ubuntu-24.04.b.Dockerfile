FROM ubuntu:24.04

USER root

ENV LANG C.UTF-8

RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak

COPY /dependency/common/sources.list /etc/apt/

RUN apt-get update && \
    apt-get -y install vim dos2unix net-tools iputils-ping telnet rsync wget tree netcat curl zip unzip tree openssh-server iproute2 less lsof cron sudo zstd && \
    apt-get clean && \
    rm -rf /etc/localtime && \
    ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

CMD ["/usr/sbin/init"]