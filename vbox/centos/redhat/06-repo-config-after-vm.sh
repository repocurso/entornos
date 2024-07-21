#!/bin/bash

echo Repository Configuring...
ssh vagrant@redhat sh -c 'cat << EOT | sudo sh -
sed -i "/repocurso/d" /etc/hosts
echo -e "192.168.100.200\trepocurso.local\trepocurso" >> /etc/hosts
cat > /etc/docker/daemon.json << EOF
{"insecure-registries": ["192.168.100.200:9091","repocurso:9091"]}
EOF
systemctl restart docker
EOT'

