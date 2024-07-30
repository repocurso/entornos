#!/bin/sh
set -o errexit

docker pull kindest/node:v1.29.0

cat <<EOT | kind create cluster --image kindest/node:v1.29.0 --config=-
apiVersion: kind.x-k8s.io/v1alpha4
kind: Cluster
name: kind
nodes:
- role: control-plane
  extraMounts:
  - hostPath: /shared
    containerPath: /shared
  extraPortMappings:
  - containerPort: 6443
    hostPort: 6443
    protocol: TCP
- role: worker
  extraMounts:
  - hostPath: /shared
    containerPath: /shared
- role: worker
  extraMounts:
  - hostPath: /shared
    containerPath: /shared
EOT

sudo chown vagrant:vagrant /shared

#kubectl config rename-context kind-c1 k8s-c1

# Initialize kind
kind get clusters
mkdir .kube
kind get kubeconfig > .kube/config

echo "**** kind Cluster started: $(date)"; echo ""
