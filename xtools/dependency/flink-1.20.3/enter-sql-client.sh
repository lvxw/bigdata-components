#!/bin/bash

source /etc/profile

sql-client.sh gateway --endpoint flink:10004 -i ${FLINK_HOME}/conf/sql-client-init.sql

