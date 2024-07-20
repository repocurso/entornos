#!/bin/bash

export KUBECONFIG=kubeconfig/config

kubectl create deployment deploy1 --image=repocurso:9091/nginx --replicas 3
kubectl get pods -owide -l app=deploy1 
kubectl wait --for=condition=available deployment/deploy1
kubectl get pods -owide -l app=deploy1 
kubectl delete deployment deploy1

for node in master node1 node2; do
ssh vagrant@$node sh -c 'cat << EOT | sudo sh -
echo "========== $HOSTNAME =========="
sudo crictl -r unix:///var/run/crio/crio.sock  images | grep -i repocurso
sudo crictl -r unix:///var/run/crio/crio.sock  rmi repocurso:9091/nginx
sudo crictl -r unix:///var/run/crio/crio.sock  images | grep -i repocurso
EOT';
done

