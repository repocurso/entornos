#!/bin/bash

cp ~/curso/entornos/hosts/data/config.json .

scp vagrant@master:/home/vagrant/.kube/config kubeconfig/
export KUBECONFIG=kubeconfig/config

kubectl create secret generic registry-credential \
--from-file=.dockerconfigjson=config.json \
--type=kubernetes.io/dockerconfigjson

kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "registry-credential"}]}'

