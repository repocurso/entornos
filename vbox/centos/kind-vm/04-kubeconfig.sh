#!/bin/bash

pid=$(pgrep -f "ssh -f -L 6443:localhost:6443 vagrant@192.168.100.150 -N")
if [  -n "$pid" ]; then
sudo kill -9 $(pgrep -f "ssh -f -L 6443:localhost:6443 vagrant@192.168.100.150 -N")
fi
/usr/bin/ssh -f -L 6443:localhost:6443 vagrant@192.168.100.150 -N
# ------------------------------
ssh vagrant@kind sudo chown vagrant:vagrant .kube/config
ssh vagrant@kind sudo sed -i 's/0.0.0.0:6443/127.0.0.1:6443/' .kube/config
export DIR=$(pwd)
if [ -d $DIR/kubeconfig ]; then rm -rf $DIR/kubeconfig; fi
mkdir -p $DIR/kubeconfig
scp vagrant@kind:/home/vagrant/.kube/config $DIR/kubeconfig/
# ------------------------------

export KUBECONFIG=$DIR/kubeconfig/config
kubectl get nodes -owide

export KUBECONFIG=$HOME/.kube/config
export CLUSTER_NAME="kind-kind"

export USER_EXISTS=$(kubectl config view -o jsonpath="{.users[?(@.name == \"$CLUSTER_NAME\")].name}" 2> /dev/null)
if [ -n "$USER_EXISTS" ]; then
  kubectl config unset users.$CLUSTER_NAME
fi

export CONTEXT_EXISTS=$(kubectl config view -o json | jq -r --arg CLUSTER_NAME "$CLUSTER_NAME" '.contexts[] | select(.context.cluster == $CLUSTER_NAME) | .name' 2> /dev/null)
if [ -n "$CONTEXT_EXISTS" ]; then
  kubectl config delete-context $CONTEXT_EXISTS
fi

export CLUSTER_EXISTS=$(kubectl config view -o jsonpath="{.clusters[?(@.name == \"$CLUSTER_NAME\")].name}" 2> /dev/null)
if [ ! -z "$CLUSTER_EXISTS" ]; then
  echo "El clúster $CLUSTER_NAME ya existe"
  kubectl config delete-cluster $CLUSTER_NAME
fi

cd $DIR/kubeconfig
KUBECONFIG=~/.kube/config:config kubectl config view --flatten > config-all

mv ~/.kube/config ~/.kube/config.org
cp ./config-all ~/.kube/config
unset KUBECONFIG

kubectl config get-contexts
kubectl config rename-context kind-kind k8s-c1
echo
kubectl config get-contexts

kubectl config use-context k8s-c1
kubectl get nodes -owide
kubectl get pods -n kube-system -owide

