#!/bin/bash

if [ ! -f $HOME/.ssh/id_rsa ]; then ssh-keygen -q -t rsa -f ~/.ssh/id_rsa -N "" <<< y > /dev/null; fi

cat > prepare.txt << EOT
vagrant
EOT

export NODE="ubuntu"
export NODE_IP=$(awk -v node="$NODE" '$0 ~ node {print $1}' /etc/hosts);

sshpass -f prepare.txt ssh-copy-id -f vagrant@$NODE_IP 
sshpass -f prepare.txt ssh-copy-id -f vagrant@$NODE 
sshpass -f prepare.txt | ssh vagrant@$NODE_IP exit;
sshpass -f prepare.txt | ssh vagrant@$NODE exit;

rm -f prepare.txt

