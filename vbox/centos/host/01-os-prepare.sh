#!/bin/bash

sudo yum install -y net-tools tree jq unzip dos2unix sshpass debootstrap nfs-utils

if [ -f /etc/selinux/config ]; then 
  sudo sed '/SELINUX=permissive/s/permissive/disabled/' /etc/selinux/config;
  sudo sed '/SELINUX=enforcing/s/enforcing/disabled/' /etc/selinux/config;
else 
  echo -e "SELINUX=disabled\nSELINUXTYPE=targeted" | sudo tee /etc/selinux/config
fi

sudo getenforce

ssh-keygen -q -t rsa -f ~/.ssh/id_rsa -N "" <<< y > /dev/null
rm -f ~/.ssh/known_hosts

sudo reboot

