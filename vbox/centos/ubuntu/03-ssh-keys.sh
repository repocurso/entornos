#!/bin/bash

cat > prepare.txt << EOT
vagrant
EOT

export NODE="ubuntu"
export NODE_IP=$(awk -v node="$NODE" '$0 ~ node {print $1}' /etc/hosts);

sshpass -f prepare.txt ssh-copy-id -o StrictHostKeyChecking=no vagrant@$NODE_IP -f
sshpass -f prepare.txt | ssh -o StrictHostKeyChecking=no vagrant@$NODE exit;

rm -f prepare.txt

