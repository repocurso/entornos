#!/bin/bash

cp ~/curso/entornos/vbox/centos/host/data/config.json .

kubectl config use-context k8s-c2

kubectl delete secret registry-credential

kubectl create secret generic registry-credential \
--from-file=.dockerconfigjson=config.json \
--type=kubernetes.io/dockerconfigjson

kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "registry-credential"}]}'

rm -f config.json

