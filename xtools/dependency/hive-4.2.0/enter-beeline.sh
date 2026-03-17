#!/bin/bash

source /etc/profile

beeline -u jdbc:hive2://hive:10000 -n root
