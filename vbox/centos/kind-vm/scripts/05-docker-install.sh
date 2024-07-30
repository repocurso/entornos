#!/bin/bash
cat > /shared/install.sh << EOT 
#!/bin/bash
echo "================ \$(hostname) ================"
export DEBIAN_FRONTEND=noninteractive
echo 'containerd.io containerd.io/config boolean true' | sudo debconf-set-selections
cat <<EOF | sudo tee /usr/sbin/policy-rc.d
#!/bin/sh
exit 101
EOF
sudo chmod +x /usr/sbin/policy-rc.d
sudo apt-get update -y -qqq > /dev/null
sudo apt-get install -y -qqq ca-certificates > /dev/null
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/\$(. /etc/os-release && echo \$ID)/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=\$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/\$(. /etc/os-release && echo \$ID) \$(. /etc/os-release && echo \$VERSION_CODENAME) stable" | sudo tee /etc/apt/sources.list.d/docker.list 
sudo apt-get update -y -qqq > /dev/null
sudo apt-get install -y -qqq -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" docker-ce docker-ce-cli containerd.io > /dev/null
sudo rm /usr/sbin/policy-rc.d
sudo service docker start
sudo usermod -aG docker vagrant
EOT

for node in kind-control-plane kind-worker kind-worker2; do docker exec -u root -i --privileged $node /bin/bash -c 'sh /shared/install.sh'; done

echo "**** docker installed: $(date)"; echo ""
