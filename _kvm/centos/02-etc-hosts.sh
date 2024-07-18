#!/bin/bash

# Modificación del archivo /etc/hosts
sudo sed -i '/centos/d' /etc/hosts
echo "192.168.100.11\tcentos.local\tcentos" | sudo tee -a /etc/hosts
