#!/bin/bash

wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --dearmor --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] http://download.virtualbox.org/virtualbox/debian $(. /etc/os-release && echo "$VERSION_CODENAME") contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
sudo systemctl daemon-reload
sudo apt update
sudo apt install -y virtualbox-7.0
vboxmanage -v | cut -dr -f1
sudo usermod -aG vboxusers $USER
echo "* 192.168.10.0/24" | sudo tee /etc/vbox/networks.conf

sudo reboot
