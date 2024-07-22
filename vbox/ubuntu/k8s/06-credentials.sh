#!/bin/bash

cp ~/curso/shared/data/config.json .

export DIR=$(pwd)
if [ ! -d $DIR/kubeconfig ]; then mkdir -p $DIR/kubeconfig; fi
scp vagrant@master:/home/vagrant/.kube/config kubeconfig/
export KUBECONFIG=kubeconfig/config

kubectl create secret generic registry-credential \
--from-file=.dockerconfigjson=config.json \
--type=kubernetes.io/dockerconfigjson

kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "registry-credential"}]}'

rm -f config.json
