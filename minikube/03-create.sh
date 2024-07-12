minikube start --nodes 3 --driver=docker --container-runtime=docker --kubernetes-version=v1.28.3 --cni calico --insecure-registry="192.168.100.200:9091" --insecure-registry="repocurso:9091"
