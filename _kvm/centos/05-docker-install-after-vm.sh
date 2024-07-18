#!/bin/bash

# ----- docker (ubuntu)
ssh vagrant@centos sh -c 'cat << EOT | sudo sh -
sudo yum remove -y docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum makecache -y fast
sudo yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker vagrant
#sudo reboot
EOT'

# ----- docker completion (ubuntu)
ssh vagrant@centos sh -c 'cat << EOT | sh -
sudo yum install -y bash-completion 
sudo curl https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker -o /etc/bash_completion.d/docker.sh
sudo reboot
EOT'
