#!/bin/bash

export KUBECONFIG=kubeconfig/config

kubectl create deployment deploy1 --image=repocurso:9091/nginx --replicas 3
kubectl get pods -owide -l app=deploy1 
kubectl wait --for=condition=available deployment/deploy1 --timeout=60s
kubectl get pods -owide -l app=deploy1 
kubectl delete deployment deploy1
kubectl wait --for=delete deployment/deploy1 --timeout=60s

echo -n "Waiting"
while true; do
  POD_COUNT=$(kubectl get pods -l app=deploy1 --no-headers | wc -l)
  if [ "$POD_COUNT" -eq 0 ]; then
    break
  else
    echo -n "."
    sleep 1
  fi
done

for node in master node1 node2; do
ssh vagrant@$node sh -c 'cat << EOT | sudo sh -
echo "========== $HOSTNAME =========="
sudo crictl -r unix:///var/run/crio/crio.sock  images | grep -i repocurso
sudo crictl -r unix:///var/run/crio/crio.sock  rmi repocurso:9091/nginx
sudo crictl -r unix:///var/run/crio/crio.sock  images | grep -i repocurso
EOT';
done

