#!/bin/bash

# Modificación del archivo /etc/hosts
sudo sed -i '/master/d; /node1/d; /node2/d' /etc/hosts
sudo sed -i '$a 192.168.100.100\tmaster.local\tmaster\n192.168.100.101\tnode1.local\tnode1\n192.168.100.102\tnode2.local\tnode2' /etc/hosts

