#!/bin/bash

sudo sed -i '/repocurso/d' /etc/hosts
echo "192.168.100.200\trepocurso.local\trepocurso" | sudo tee -a /etc/hosts

echo {\"insecure-registries\": [\"192.168.100.200:9091\",\"repocurso:9091\"]} | sudo tee /etc/docker/daemon.json
echo "Docker Starting..."
sudo systemctl daemon-reload
sudo systemctl restart docker

echo -n "repocurso:9091 Connecting: "
docker login repocurso:9091 --username admin --password container@13 2> /dev/null
echo -n "192.168.100.200:9091 Connecting: "
docker login 192.168.100.200:9091 --username admin --password container@13 2> /dev/null
echo

#export DIR=$(pwd)
#if [ -d "$DIR/data" ]; then rm -rf $DIR/data; fi
#mkdir -p $DIR/data
#jq -c . $HOME/.docker/config.json > $DIR/data/config.json
#chmod 400 $DIR/data/config.json

export DIR="$HOME/shared"
if [ -d "$DIR/data" ]; then rm -rf $DIR/data; fi
mkdir -p $DIR/data
jq -c . $HOME/.docker/config.json > $DIR/data/config.json
chmod 400 $DIR/data/config.json


echo
docker logout repocurso:9091
docker logout 192.168.100.200:9091
