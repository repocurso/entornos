#!/bin/bash

mkdir -p ~/download/k8s && cd ~/download/k8s

curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl

curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl.sha256

echo "$(cat kubectl.sha256) kubectl" | sha256sum --check

# -------------------------------

chmod +x kubectl
sudo cp ./kubectl /usr/local/bin/kubectl
kubectl version

# -------------------------------

type _init_completion 
echo 'source <(kubectl completion bash)' >> ~/.bashrc

kubectl completion bash > ~/kubectl.completion
sudo cp ~/kubectl.completion /etc/bash_completion.d/kubectl
sudo ls /etc/bash_completion.d/kubectl

echo 'alias k=kubectl' >> ~/.bashrc 
echo 'complete -o default -F __start_kubectl k' >> ~/.bashrc 


