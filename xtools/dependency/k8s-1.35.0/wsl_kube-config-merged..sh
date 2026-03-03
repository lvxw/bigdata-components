#!/bin/bash

if [[ ! -f /root/.kube/config.local ]]
then
   mv /root/.kube/config /root/.kube/config.local
fi

cp -r /root/.kube/config.local /tmp/config
docker cp k8s:/root/.kube/config /tmp/config2

export KUBECONFIG=/tmp/config:/tmp/config2

kubectl config view --flatten > /root/.kube/config

cp -f /root/.kube/config /mnt/c/Users/slwx/.kube/

unset KUBECONFIG

kubectl config use-context kind-podman-k8s-cluster

kubectl config get-contexts