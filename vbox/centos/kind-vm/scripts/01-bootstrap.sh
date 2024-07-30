#!/bin/bash

# ========== Install docker ==========
sudo apt-get update -qqq
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common > /dev/null
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -qqq
apt-cache policy -qqq docker-ce docker-ce-cli containerd.io > /dev/null
sudo apt-get install -y -qqq docker-ce docker-ce-cli containerd.io > /dev/null
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker vagrant

# ----- docker completion
sudo apt-get install -y -qqq bash-completion > /dev/null
sudo curl https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker -o /etc/bash_completion.d/docker.sh

echo "**** End installing Docker CE"

# ========== Install kubectl ==========
export DIR=$(pwd)
#if [ ! -d "$DIR/data" ]; then mkdir -p $DIR/data; fi
#if [ ! -f "$DIR/data/bashrc" ]; then cp $HOME/.bashrc $DIR/data/bashrc; fi
if [ ! -d "/shared/data" ]; then mkdir -p /shared/data; fi
if [ ! -f "/shared/data/bashrc" ]; then cp $HOME/.bashrc /shared/data/bashrc; fi

if [ -d "$HOME/download/k8s" -o -f "$HOME/download/k8s" ]; then rm -rf $HOME/download/k8s; fi
mkdir -p $HOME/download/k8s && cd $HOME/download/k8s

curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl > /dev/null
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl.sha256 > /dev/null
echo "$(cat kubectl.sha256) kubectl" | sha256sum --check

# -------------------------------

chmod +x kubectl
sudo cp ./kubectl /usr/local/bin/kubectl
kubectl version --client=true

# -------------------------------

#cp -f $DIR/data/bashrc $HOME/.bashrc
cp -f /shared/data/bashrc $HOME/.bashrc
type _init_completion 
echo 'source <(kubectl completion bash)' >> $HOME/.bashrc

kubectl completion bash > ~/kubectl.completion
sudo mv ~/kubectl.completion /etc/bash_completion.d/kubectl
sudo ls /etc/bash_completion.d/kubectl

echo 'alias k=kubectl' >> ~/.bashrc 
echo 'complete -o default -F __start_kubectl k' >> ~/.bashrc 

echo "**** End installing kubectl"

# ========== Install kind ==========
mkdir -p ~/download/kind && cd ~/download/kind 
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.17.0/kind-linux-amd64 > /dev/null
chmod +x ./kind 
sudo cp ./kind /usr/local/bin 
kind version
echo "**** End installing kind"

echo "**** host node software installed: $(date)"; echo ""

