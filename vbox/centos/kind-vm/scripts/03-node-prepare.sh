#!/bin/bash

cat << EOT | sudo sh -
for node in kind-control-plane kind-worker kind-worker2; do
docker exec -u root -i \$node /bin/bash -c "echo ========== \$node ========== ; apt update -qqq > /dev/null; apt-get install -y -qqq sudo vim tree acl wget curl dpkg net-tools iputils-ping openssh-client > /dev/null; useradd -u 1014 -s /bin/bash -m vagrant ; echo \"vagrant ALL=(ALL:ALL) NOPASSWD: ALL\" >> /etc/sudoers";
done

docker exec -u root -i kind-control-plane /bin/bash -c "chmod +r /etc/kubernetes/admin.conf";
EOT

echo "**** node cluster prepared: $(date)"; echo ""
