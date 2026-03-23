#!/bin/bash

source /etc/profile

sql-client.sh -i ${FLINK_HOME}/conf/sql-client-init.sql
