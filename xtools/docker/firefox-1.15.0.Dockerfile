FROM kasmweb/firefox:1.15.0-rolling

USER root

RUN sudo rm -rf /etc/localtime && \
    ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

USER 1000