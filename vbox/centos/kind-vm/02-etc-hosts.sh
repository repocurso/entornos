#!/bin/bash

# Modificación del archivo /etc/hosts
sudo sed -i '/kind/d' /etc/hosts
echo -e "192.168.100.150\tkind.local\tkind" | sudo tee -a /etc/hosts
