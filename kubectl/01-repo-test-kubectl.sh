#!/bin/bash

for context in k8s-c1 k8s-c2 k8s-c3; do
  echo "========== $context =========="
  kubectl config use-context $context
  kubectl apply -f 01-repo-test-kubectl.yml 
  kubectl get pods -owide
  sleep 15
  kubectl get pods -owide
  sleep 5
  kubectl delete --force -f 01-repo-test-kubectl.yml;
done 

for node in c1-control-plane c1-worker c1-worker2; do
docker exec -u root -it --privileged $node /bin/bash -c 'cat << EOT | sh -
echo "========== $HOSTNAME =========="
crictl -r unix:///run/containerd/containerd.sock images | grep -i repocurso
crictl -r unix:///run/containerd/containerd.sock rmi repocurso:9091/nginx
crictl -r unix:///run/containerd/containerd.sock images | grep -i repocurso
exit
EOT';
done

for node in minikube minikube-m02 minikube-m03; do
minikube ssh -n $node << EOT 
cat << EOF | sh -
echo "========== $node =========="
docker images | grep -i repocurso
docker rmi -f repocurso:9091/nginx 
docker images | grep -i repocurso
EOF
exit
EOT
done

for node in master node1 node2; do
ssh vagrant@$node sh -c 'cat << EOT | sudo sh -
echo "========== $HOSTNAME =========="
sudo crictl -r unix:///var/run/crio/crio.sock  images | grep -i repocurso
sudo crictl -r unix:///var/run/crio/crio.sock  rmi repocurso:9091/nginx
sudo crictl -r unix:///var/run/crio/crio.sock  images | grep -i repocurso
exit
EOT';
done
