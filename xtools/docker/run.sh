#!/bin/bash

SCRIPT_PATH=$(cd `dirname $0` && pwd)

cd ${SCRIPT_PATH}

if [[ $# -ne 2 ]]
then
  echo "请传入两个参数， 参数一： 组件名[hadoop|flink|hive...]， 第二个参数： 组件版本号[3.1.4|1.14.6]"
  exits -1
else
  COMPONENT_TYPE=${1}
  COMPONENT_VERSION=${2}
fi

docker network create \
  --subnet 172.18.0.0/16 \
  --gateway 172.18.0.1 \
  --driver bridge \
  test

docker rm -f ${COMPONENT_TYPE}

DOCKER_CDM="docker run \
    --privileged=true \
    --network test \
    --name ${COMPONENT_TYPE} \
    --hostname ${COMPONENT_TYPE}  \
    -d registry.cn-hangzhou.aliyuncs.com/lvxw_test/${COMPONENT_TYPE}:${COMPONENT_VERSION}"

echo ${DOCKER_CDM}

eval "${DOCKER_CDM}"


