#!/bin/bash

# Modificación del archivo /etc/hosts
sudo sed -i '/manager/d; /worker01/d; /worker02/d' /etc/hosts
sudo sed -i '$a 192.168.100.50\tmanager.local\tmanager\n192.168.100.51\tworker01.local\tworker01\n192.168.100.52\tworker02.local\tworker02' /etc/hosts

