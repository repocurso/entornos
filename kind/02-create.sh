#!/bin/bash

docker pull kindest/node:v1.29.0

cat << EOT | kind create cluster --image kindest/node:v1.29.0 --config=-
apiVersion: kind.x-k8s.io/v1alpha4
kind: Cluster
name: c1
nodes:
- role: control-plane
  extraMounts:
  - hostPath: /home/pue/shared
    containerPath: /shared
- role: worker
- role: worker
EOT

