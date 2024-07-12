#!/bin/bash

export KUBECONFIG=kubeconfig/config

kubectl create deployment deploy1 --image=repocurso:9091/nginx --replicas 3
kubectl get pods -l app=deploy1 --watch
kubectl delete deployment deploy1

