#!/bin/bash

for node in c1-control-plane c1-worker c1-worker2; do
docker exec -u root -it --privileged $node /bin/bash -c 'cat << EOT | sh -
echo ================ $HOSTNAME ================
apt-get update -y
echo "N" | sudo dpkg --configure -a
apt-get install -y ca-certificates 
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release && echo $ID)/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/$(. /etc/os-release && echo $ID) $(. /etc/os-release && echo $VERSION_CODENAME) stable" | tee /etc/apt/sources.list.d/docker.list 
apt-get update -y
echo "N" | sudo dpkg --configure -a
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
service docker start
sudo usermod -aG docker user1
EOT';
done

