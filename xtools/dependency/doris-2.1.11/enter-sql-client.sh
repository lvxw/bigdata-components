#!/bin/bash

source /etc/profile

mysql --ssl-mode=DISABLE -uroot -proot -P49030 -hdoris -Dtest
