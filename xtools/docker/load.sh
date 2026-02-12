#!/bin/bash

SCRIPT_PATH=$(cd `dirname $0` && pwd)

cd ${SCRIPT_PATH}

if [[ $# -ne 2 ]]
then
  echo "请传入两个参数， 参数一： 组件名[hadoop|flink|hive...]， 第二个参数： 组件版本号[3.1.4|1.14.6]"
  exit -1
else
  COMPONENT_TYPE=${1}
  COMPONENT_VERSION=${2}
fi

docker rm -f ${COMPONENT_TYPE}

gunzip -c /data/nfs/${COMPONENT_TYPE}-${COMPONENT_VERSION}.tgz  |  docker load