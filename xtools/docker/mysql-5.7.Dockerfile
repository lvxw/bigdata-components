FROM mysql:5.7

ENV LANG C.UTF-8

RUN echo "export  LANG=C.UTF-8"  >> /etc/profile

COPY /dependency/mysql-5.7/init.sql  /docker-entrypoint-initdb.d/

COPY /dependency/mysql-5.7/my.cnf /etc/

RUN chmod 644 /etc/my.cnf && \
    rm -rf /etc/localtime && \
    ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
