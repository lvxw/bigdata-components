FROM clickhouse/clickhouse-server:21.3.20.1

ARG CLICKHOUSE_VERSION="21.3.20.1"

ADD /dependency/clickhouse-${CLICKHOUSE_VERSION}/init-db.sh /docker-entrypoint-initdb.d/
ADD /dependency/clickhouse-${CLICKHOUSE_VERSION}/users.xml /etc/clickhouse-server/

RUN chmod 755  /docker-entrypoint-initdb.d/init-db.sh &&\
  echo '#!/bin/bash' > /usr/local/bin/enter-clickhouse.sh &&\
  echo ' ' >> /usr/local/bin/enter-clickhouse.sh &&\
  echo 'clickhouse-client --host localhost --port 9000 --user default --password default --database adsdb' >> /usr/local/bin/enter-clickhouse.sh &&\
  /usr/bin/chmod 755  /usr/local/bin/enter-clickhouse.sh