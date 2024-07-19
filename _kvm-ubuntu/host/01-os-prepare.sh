#!/bin/bash

sudo apt install -y net-tools tree jq unzip dos2unix sshpass debootstrap selinux-utils policycoreutils

if [ -f /etc/selinux/config ]; then 
  sudo sed -i '/SELINUX=permissive/s/permissive/disabled/' /etc/selinux/config;
  sudo sed -i '/SELINUX=enforcing/s/enforcing/disabled/' /etc/selinux/config;
else 
  echo -e "SELINUX=disabled\nSELINUXTYPE=targeted" | sudo tee /etc/selinux/config
fi

sudo sestatus

#ssh-keygen -q -t rsa -f ~/.ssh/id_rsa -N "" <<< y > /dev/null
rm -f ~/.ssh/id_rsa*
ssh-keygen -q -t rsa -f ~/.ssh/id_rsa -N "" 
rm -f ~/.ssh/known_hosts

sudo reboot

