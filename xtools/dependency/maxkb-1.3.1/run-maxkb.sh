#!/bin/bash

# Start postgresql
docker-entrypoint.sh postgres &
sleep 10
# Wait postgresql
until pg_isready --host=127.0.0.1; do sleep 1 && echo "waiting for postgres"; done

# Start MaxKB
nohup python /opt/maxkb/app/main.py start > /opt/maxkb/logs/start.log 2>&1 &

while [[ `echo -e '\n' | telnet 127.0.0.1 8080 2> /dev/null | grep Connected | wc -l` -eq 0 ]]
do
  echo "check maxkb server ......"
  sleep 1s
done

psql -U root -d maxkb -f /opt/maxkb/conf/init.sql

tail -n 1000000 -f /opt/maxkb/logs/start.log