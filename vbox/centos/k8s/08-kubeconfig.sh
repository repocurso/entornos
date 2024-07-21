#!/bin/bash

export KUBECONFIG=kubeconfig/config

export DIR=/curso/entornos/vbox/centos/k8s/kubeconfig
cd $HOME/$DIR

KUBECONFIG=~/.kube/config:config kubectl config view --flatten > config-all

mv ~/.kube/config ~/.kube/config.org
cp ./config-all ~/.kube/config
unset KUBECONFIG

kubectl config get-contexts
kubectl config rename-context kubernetes-admin@kubernetes k8s-c3
echo
kubectl config get-contexts

kubectl config use-context k8s-c3
kubectl get pods -n kube-system

