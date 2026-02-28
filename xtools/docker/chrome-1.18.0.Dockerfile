FROM docker.io/kasmweb/chrome:1.18.0-rolling-daily

USER root

RUN sudo rm -rf /etc/localtime && \
    ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

USER 1000