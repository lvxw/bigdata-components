#!/bin/bash

nohup /usr/bin/dockerd > /dev/null 2>&1 &

/usr/local/src/harbor/install.sh

tail -f ~/.bashrc
