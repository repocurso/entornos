#!/bin/bash

# Modificación del archivo /etc/hosts
sudo sed -i '/centos/d' /etc/hosts
echo -e "192.168.33.11\tcentos.local\tcentos" | sudo tee -a /etc/hosts
