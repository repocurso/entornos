#!/bin/bash

echo Configuring Repository...
echo "192.168.100.200 repocurso" >> /etc/hosts
echo '{"insecure-registries": ["192.168.100.200:9091","repocurso:9091"]}' > /etc/docker/daemon.json
systemctl restart docker

