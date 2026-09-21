FROM mysql:5.7

ENV LANG C.UTF-8

RUN echo "export  LANG=C.UTF-8"  >> /etc/profile

ARG MYSQL_VERSION="5.7"

COPY /dependency/mysql-${MYSQL_VERSION}/init.sql  /docker-entrypoint-initdb.d/

COPY /dependency/mysql-${MYSQL_VERSION}/my.cnf /etc/

RUN chmod 644 /etc/my.cnf && \
    rm -rf /etc/localtime && \
    ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
