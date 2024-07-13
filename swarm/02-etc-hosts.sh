#!/bin/bash

# Modificación del archivo /etc/hosts
sudo sed -i '/manager/d; /worker01/d; /worker02/d' /etc/hosts
sudo sed -i '$a 10.100.199.200\tmanager.local\tmanager\n10.100.199.201\tworker01.local\tworker01\n10.100.199.202\tworker02.local\tworker02' /etc/hosts

