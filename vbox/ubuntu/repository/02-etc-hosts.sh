#!/bin/bash

# Modificación del archivo /etc/hosts
sudo sed -i '/repocurso/d' /etc/hosts
echo "192.168.100.200\trepocurso.local\trepocurso" | sudo tee -a /etc/hosts
