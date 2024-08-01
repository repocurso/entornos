#!/bin/bash

echo "* 192.168.57.0/24" | sudo tee -a /etc/vbox/networks.conf
VBoxManage hostonlyif create
VBoxManage hostonlyif ipconfig vboxnet1 --ip 192.168.57.1 --netmask 255.255.255.0
VBoxManage dhcpserver remove --netname vboxnet1
VBoxManage dhcpserver add --netname vboxnet1 --ip 192.168.57.1 --netmask 255.255.255.0 --lowerip 192.168.57.100 --upperip 192.168.57.102 --enable

minikube start --nodes 3 --driver=virtualbox --host-only-cidr=192.168.57.1/24 --cpus=2 --memory=3072 --disk-size=64g --container-runtime=docker --kubernetes-version=v1.28.3 --keep-context --cni calico --insecure-registry="192.168.100.200:9091" --insecure-registry="repocurso:9091"

minikube stop
echo "**** VMs minikube stopped: $(date)"; echo ""

for vm in $(VBoxManage list vms | grep minikube | cut -d '"' -f 2); do
  VBoxManage modifyvm "$vm" --groups "/minikube-k8s"
done
echo "**** VMs minikube groupped: $(date)"; echo ""

minikube start 
echo "**** VMs minikube started: $(date)"; echo ""

kubectl config delete-context k8s-c2
kubectl config rename-context minikube k8s-c2

