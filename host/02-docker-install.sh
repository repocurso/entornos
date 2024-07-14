#!/bin/bash

# ----- Desinstalacion de docker
sudo yum remove -y docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine
sudo yum remove -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
sudo rm -rf /var/lib/docker 
sudo rm -rf /var/lib/containerd

# ----- Instalacion de docker
sudo yum install -y yum-utils

sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

sudo yum makecache -y fast

sudo yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras

sudo systemctl start docker
sudo systemctl enable docker

sudo usermod -aG docker pue

sudo docker version

sudo reboot

