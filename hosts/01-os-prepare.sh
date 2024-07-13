#!/bin/bash

if [ -f /etc/selinux/config ]; then 
echo bien; 
sudo sed '/SELINUX=permissive/s/permissive/disabled/' /etc/selinux/config;
sudo sed '/SELINUX=enforcing/s/enforcing/disabled/' /etc/selinux/config;
else 
echo mal; 
echo "SELINUX=disabled" | sudo tee /etc/selinux/config
fi

sudo getenforce
#sudo reboot

