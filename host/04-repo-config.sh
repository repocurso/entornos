#!/bin/bash

sudo sed -i '/repocurso/d' /etc/hosts
echo -e "192.168.100.200\trepocurso.local\trepocurso" | sudo tee -a /etc/hosts

echo -e {\"insecure-registries\": [\"192.168.100.200:9091\",\"repocurso:9091\"]} | sudo tee /etc/docker/daemon.json
echo "Docker Starting..."
sudo systemctl restart docker

echo -n "repocurso:9091 Connecting: "
docker login repocurso:9091 --username admin --password container@13 2> /dev/null
echo -n "192.168.100.200:9091 Connecting: "
docker login 192.168.100.200:9091 --username admin --password container@13 2> /dev/null
echo

docker pull --quiet 192.168.100.200:9091/hello-world
docker run --rm --quiet repocurso:9091/hello-world
docker images 
docker rmi repocurso:9091/hello-world 192.168.100.200:9091/hello-world > /dev/null
echo
docker images

export DIR=$(pwd)
if [ ! -d "$DIR/data" ]; then mkdir -p $DIR/data; fi
if [ ! -f "$DIR/data/config.json" ]; then jq -c . $HOME/.docker/config.json > $DIR/data/config.json; fi

echo
docker logout repocurso:9091
docker logout 192.168.100.200:9091
