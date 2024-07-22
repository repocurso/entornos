#!/bin/bash

mkdir -p ~/download/kind && cd ~/download/kind 
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.17.0/kind-linux-amd64
chmod +x ./kind 
sudo cp ./kind /usr/local/bin 
kind version

