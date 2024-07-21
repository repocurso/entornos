#!/bin/bash

# Modificación del archivo /etc/hosts
sudo sed -i '/redhat/d' /etc/hosts
echo -e "192.168.100.11\tredhat.local\tredhat" | sudo tee -a /etc/hosts
