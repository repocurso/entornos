#!/bin/bash

for node in c1-control-plane c1-worker c1-worker2; do
docker exec -u root -it $node /bin/bash -c "echo ===== $node ===== ; apt update ; apt-get install -y sudo vim tree acl wget curl dpkg net-tools iputils-ping openssh-client; useradd -u 1014 -s /bin/bash -m user1 ; echo 'user1 ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers";
done

for node in c1-control-plane; do
docker exec -u root -it $node /bin/bash -c "chmod +r /etc/kubernetes/admin.conf";
done

