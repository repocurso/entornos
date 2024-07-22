#/bin/bash

if [ ! -f $HOME/.ssh/id_rsa ]; then ssh-keygen -q -t rsa -f ~/.ssh/id_rsa -N "" ; fi

cat > prepare.txt << EOT
vagrant
EOT

for NODE in master node1 node2; do 
  rm -f ~/.ssh/known_host
  NODE_IP=$(awk -v node="$NODE" '$0 ~ node {print $1}' /etc/hosts);

  sshpass -f prepare.txt | ssh vagrant@$NODE hostname 
  sshpass -f prepare.txt | ssh vagrant@$NODE_IP hostname
  rm -f ~/.ssh/known_host

  sshpass -f prepare.txt ssh-copy-id -f vagrant@$NODE 
  sshpass -f prepare.txt ssh-copy-id -f vagrant@$NODE_IP 
  rm -f ~/.ssh/known_host

done

rm -f prepare.txt

