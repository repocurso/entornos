#!/bin/bash

# Modificación del archivo /etc/hosts
sudo sed -i '/ubuntu/d' /etc/hosts
echo -e "192.168.100.12\tubuntu.local\tubuntu" | sudo tee -a /etc/hosts
