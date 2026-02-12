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

PODMAN_CMD="podman build \
    -t 10.10.52.13:5000/lakehouse/${COMPONENT_TYPE}:${COMPONENT_VERSION} \
    -f ./${COMPONENT_TYPE}-${COMPONENT_VERSION}.Dockerfile \
    ../"

eval ${PODMAN_CMD} && \
podman push 10.10.52.13:5000/lakehouse/${COMPONENT_TYPE}:${COMPONENT_VERSION}  docker-daemon:10.10.52.13:5000/lakehouse/${COMPONENT_TYPE}:${COMPONENT_VERSION} && \
docker image prune -f && \
podman image prune -f