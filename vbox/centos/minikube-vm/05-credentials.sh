#!/bin/bash

if [ ! -f ~/curso/shared/data/config.json ]; then echo "No existe el archivo de claves"; exit; fi
cp ~/curso/shared/data/config.json .

kubectl config use-context k8s-c2

kubectl delete secret registry-credential

kubectl create secret generic registry-credential \
--from-file=.dockerconfigjson=config.json \
--type=kubernetes.io/dockerconfigjson

kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "registry-credential"}]}'

rm -f config.json

echo "**** kubernetes credentials configured: $(date)"; echo ""
