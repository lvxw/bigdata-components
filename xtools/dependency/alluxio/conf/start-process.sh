#!/bin/bash

nohup /entrypoint.sh master > /tmp/start-alluxio-master.log 2>&1 &
nohup /entrypoint.sh worker > /tmp/start-alluxio-worker.log 2>&1 &

while [[ `cat /tmp/start-alluxio-master.log | grep  'Worker successfully registered' | wc -l` -eq 0 ]]
do
   nohup echo "sleep ......" >> /tmp/sleep.log 2>&1 &
   sleep 5s
done

nohup alluxio fs mkdir /data > /tmp/mkdir.log 2>&1 &

tail -f /tmp/start-alluxio-master.log

