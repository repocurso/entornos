#!/bin/bash

export DIR=$(pwd)
if [ ! -d "$DIR/data" ]; then mkdir -p $DIR/data; fi
if [ ! -f "$DIR/data/bashrc" ]; then cp $HOME/.bashrc $DIR/data/bashrc; fi

if [ -d "$HOME/download/k8s" -o -f "$HOME/download/k8s" ]; then rm -rf $HOME/download/k8s; fi
mkdir -p $HOME/download/k8s && cd $HOME/download/k8s

curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl

curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl.sha256

echo "$(cat kubectl.sha256) kubectl" | sha256sum --check

# -------------------------------

chmod +x kubectl
sudo cp ./kubectl /usr/local/bin/kubectl
kubectl version --client=true

# -------------------------------

cp -f $DIR/data/bashrc $HOME/.bashrc
type _init_completion 
echo 'source <(kubectl completion bash)' >> $HOME/.bashrc

kubectl completion bash > ~/kubectl.completion
sudo mv ~/kubectl.completion /etc/bash_completion.d/kubectl
sudo ls /etc/bash_completion.d/kubectl

echo 'alias k=kubectl' >> ~/.bashrc 
echo 'complete -o default -F __start_kubectl k' >> ~/.bashrc 


