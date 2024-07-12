#!/bin/bash

for node in master node1 node2; do
ssh vagrant@$node sh -c 'cat << EOT | sudo sh -
sudo crictl -r unix:///var/run/crio/crio.sock  pull --creds "admin:curso-k8s@20" 192.168.100.200:9091/nginx
sudo crictl -r unix:///var/run/crio/crio.sock  pull --creds "admin:curso-k8s@20" repocurso:9091/nginx
sudo crictl -r unix:///var/run/crio/crio.sock  images
sudo crictl -r unix:///var/run/crio/crio.sock  rmi 192.168.100.200:9091/nginx
sudo crictl -r unix:///var/run/crio/crio.sock  rmi repocurso:9091/nginx
sudo crictl -r unix:///var/run/crio/crio.sock  images
EOT';
done
