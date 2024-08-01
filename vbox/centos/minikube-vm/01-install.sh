#!/bin/bash

if [ -d ~/download/minikube ]; then rm -rf ~/download/minikube; fi
mkdir -p ~/download/minikube && cd ~/download/minikube 
wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube-linux-amd64
sudo cp minikube-linux-amd64 /usr/local/bin/minikube
minikube version

echo "**** minikube installed: $(date)"; echo ""
