#!/bin/bash

docker pull kindest/node:v1.29.0

#mkdir -p $HOME/curso/shared/data
#mkdir -p $HOME/curso/shared/master $HOME/curso/shared/node1 $HOME/curso/shared/node2
#touch $HOME/curso/shared/master $HOME/curso/shared/node1 $HOME/curso/shared/node2

cat << EOT | kind create cluster --image kindest/node:v1.29.0 --config=-
apiVersion: kind.x-k8s.io/v1alpha4
kind: Cluster
name: c1
nodes:
- role: control-plane
  extraMounts:
  - hostPath: $HOME/curso/shared/data
    containerPath: /shared
#  - hostPath: $HOME/curso/shared/control-plane
#    containerPath: /etc/hosts
- role: worker
#  extraMounts:
#  - hostPath: $HOME/curso/shared/worker
#    containerPath: /etc
- role: worker
#  extraMounts:
#  - hostPath: $HOME/curso/shared/worker2
#    containerPath: /etc
EOT

kubectl config rename-context kind-c1 k8s-c1

