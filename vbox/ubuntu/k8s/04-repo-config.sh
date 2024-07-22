#!/bin/bash

for node in master node1 node2; do
ssh vagrant@$node sh -c 'cat << EOT | sudo sh - 
echo "192.168.100.200 repocurso" >> /etc/hosts
cat > /etc/containers/registries.conf.d/crio.conf << EOF
unqualified-search-registries = ["docker.io", "quay.io", "192.168.100.200:9091", "repocurso:9091"]

[[registry]]
location="192.168.100.200:9091"
insecure=true

[[registry]]
location="repocurso:9091"
insecure=true
EOF
sudo systemctl restart crio
EOT';
done
