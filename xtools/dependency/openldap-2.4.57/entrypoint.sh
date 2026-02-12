#!/bin/bash

nohup /container/tool/run > /tmp/openldap.log 2>&1 &

sleep 2s

ldapadd -x -D "cn=admin,dc=openldap,dc=com" -w "admin" -f /usr/local/src/ou_ldif_file.ldif
ldapadd -x -D "cn=admin,dc=openldap,dc=com" -w "admin" -f /usr/local/src/user_ldif_file.ldif

tail -f /tmp/openldap.log

