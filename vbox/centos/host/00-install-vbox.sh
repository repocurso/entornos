#!/bin/bash

sudo yum -y install epel-release
sudo yum -y install gcc dkms make qt libgomp patch
sudo yum -y install kernel-headers kernel-devel binutils glibc-headers glibc-devel
sudo wget http://download.virtualbox.org/virtualbox/rpm/rhel/virtualbox.repo --output-document /etc/yum.repos.d/virtualbox.repo
sudo yum install -y VirtualBox-7.0

vboxmanage -v | cut -dr -f1
sudo usermod -aG vboxusers $USER
echo "* 192.168.100.0/24" | sudo tee /etc/vbox/networks.conf

