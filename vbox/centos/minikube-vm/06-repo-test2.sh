#!/bin/bash

kubectl config use-context k8s-c2

kubectl delete deployment --force deploy1 2> /dev/null 
kubectl create deployment deploy1 --image=repocurso:9091/nginx --replicas 3
kubectl get pods -owide -l app=deploy1
kubectl wait --for=condition=available --timeout=300s deployment/deploy1
kubectl get pods -owide -l app=deploy1
kubectl delete deployment --force deploy1 2> /dev/null 
while kubectl get pods -l app=deploy1 -o jsonpath='{.items[*].status.phase}' | grep -q 'Running\|Pending\|ContainerCreating'; do
  echo -n "."
  sleep 2
done
echo ""

for node in minikube minikube-m02 minikube-m03; do
echo "========== $node =========="
minikube ssh -n $node << EOT 
docker rmi -f repocurso:9091/nginx 
docker images
exit
EOT
done

echo "**** test2 repository finalized: $(date)"; echo ""
