#!/bin/bash

export DIR=$(pwd)
if [ ! -d "$DIR/data" ]; then mkdir -p $DIR/data; fi
if [ ! -f "$DIR/data/bashrc" ]; then cp $HOME/.bashrc $DIR/data/bashrc; fi

if [ -d "$HOME/download/kubectl" -o -f "$HOME/download/kubectl" ]; then rm -rf $HOME/download/kubectl; fi
mkdir -p $HOME/download/kubectl && cd $HOME/download/kubectl

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

#sudo reboot

