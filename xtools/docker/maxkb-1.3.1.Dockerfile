FROM 1panel/maxkb:v1.3.1

RUN apt-get update && \
    apt-get -y install net-tools telnet && \
    apt-get clean

ARG MAXKB_VERSION="1.3.1"

RUN mkdir -p /tmp/tmp.mdxnTBPjaf /opt/maxkb/logs

COPY /dependency/maxkb-${MAXKB_VERSION}/init.sql /opt/maxkb/conf/
COPY /dependency/maxkb-${MAXKB_VERSION}/run-maxkb.sh  /usr/bin/

RUN chmod 755 /usr/bin/run-maxkb.sh && \
    sed -i "s/MaxKB@123../admin/g" /opt/maxkb/app/apps/users/migrations/0001_initial.py