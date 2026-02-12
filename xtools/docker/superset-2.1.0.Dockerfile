FROM docker.io/apache/superset:2.1.0

USER root

ARG SUPERSET_VERSION="2.1.0"

COPY /dependency/common/mysql-client_5.7.42-1debian10_amd64.deb /usr/local/src/
COPY /dependency/common/mysql-common_5.7.42-1debian10_amd64.deb /usr/local/src/
COPY /dependency/common/mysql-community-client_5.7.42-1debian10_amd64.deb /usr/local/src/

RUN apt-get update  && \
    apt-get -y install vim wget net-tools dos2unix rsync telnet tree psmisc libaio1 libnuma1 libatomic1 libmecab2 libgpm2 libncursesw6 libtinfo6 ncurses-bin libncurses6 procps

COPY /dependency/superset-${SUPERSET_VERSION}/run-server.sh /usr/bin/

RUN dpkg -i /usr/local/src/mysql-common_5.7.42-1debian10_amd64.deb /usr/local/src/mysql-community-client_5.7.42-1debian10_amd64.deb /usr/local/src/mysql-client_5.7.42-1debian10_amd64.deb && \
    rm -rf /usr/local/src/* && \
    chmod 755 /usr/bin/run-server.sh

USER superset

COPY /dependency/superset-${SUPERSET_VERSION}/config.py /app/superset/
COPY /dependency/superset-${SUPERSET_VERSION}/init.sql /app/

ENV SUPERSET_SECRET_KEY superset