#!/bin/bash

mkdir -p ~/.minikube/files/etc && cd ~/.minikube/files/etc

cat > hosts << EOT
127.0.0.1       localhost
::1             localhost   ip6-localhost ip6-loopback
192.168.100.200 repocurso
EOT
