#!/bin/bash

for node in manager worker01 worker02; do
ssh vagrant@$node sh -c 'cat << EOT | sudo sh - 
sed -i "/repocurso/d" /etc/hosts
echo "\$a 192.168.100.200\trepocurso.local\trepocurso" /etc/hosts
#cat > /etc/docker/daemon.json << EOF
#{ "insecure-registries": ["192.168.100.200:9091","repocurso:9091"] }
#EOF
#systemctl restart docker
EOT';
done
