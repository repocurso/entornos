#/bin/bash

ssh-keygen -q -t rsa -f ~/.ssh/id_rsa -N "" <<< y > /dev/null

cat > prepare.txt << EOT
vagrant
EOT

for NODE in master node1 node2; do 
  NODE_IP=$(awk -v node="$NODE" '$0 ~ node {print $1}' /etc/hosts);
  sshpass -f prepare.txt ssh-copy-id -o StrictHostKeyChecking=no vagrant@$NODE_IP -f
  sshpass -f prepare.txt | ssh -o StrictHostKeyChecking=no vagrant@$NODE exit;
done

rm -f prepare.txt

