#!/bin/bash

kubectl config use-context k8s-c2

kubectl delete deployment --force deploy1 2> /dev/null 
kubectl create deployment deploy1 --image=repocurso:9091/nginx --replicas 3
kubectl get pods -owide -l app=deploy1
sleep 15
kubectl get pods -owide -l app=deploy1
kubectl delete deployment --force deploy1 2> /dev/null 

for node in minikube minikube-m02 minikube-m03; do
#ssh -i ~/.minikube/machines/$node/id_rsa docker@$(minikube ip -p $node) -c 'cat << EOT | sh -
minikube ssh -n $node << EOT 
cat << EOF | sh -
echo "========== $node =========="
docker rmi -f repocurso:9091/nginx 
docker images
EOF
exit
EOT
done

