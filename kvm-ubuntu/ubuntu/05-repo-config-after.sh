#!/bin/bash

echo Configuring Repository...
sudo sed -i "/repocurso/d" /etc/hosts
echo "192.168.100.200\trepocurso.local\trepocurso" | sudo tee -a /etc/hosts
echo '{"insecure-registries": ["192.168.100.200:9091","repocurso:9091"]}' | sudo tee /etc/docker/daemon.json
systemctl restart docker

