#!/bin/bash

source /etc/profile

beeline --incremental=true -u 'jdbc:hive2://flink:10003/rt_ods;auth=noSasl' -n root -p root --force true -i ${FLINK_HOME}/conf/sql-client-init.sql