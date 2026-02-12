FROM ubuntu:23.04

USER root

RUN apt-get update && \
    apt-get -y install vim wget net-tools dos2unix rsync telnet language-pack-zh-hans openssh-client

COPY /conf/start-process.sh /usr/local/bin/

RUN dos2unix /usr/local/bin/start-process.sh

ENTRYPOINT ["/bin/bash", "/usr/local/bin/start-process.sh"]
