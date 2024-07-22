#!/bin/bash

cp ~/curso/shared/data/config.json .

kubectl config use-context k8s-c1

kubectl create secret generic registry-credential \
--from-file=.dockerconfigjson=config.json \
--type=kubernetes.io/dockerconfigjson

kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "registry-credential"}]}'

rm -f config.json

