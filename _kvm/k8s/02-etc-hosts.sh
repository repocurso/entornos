#!/bin/bash

# Modificación del archivo /etc/hosts
sudo sed -i '/master/d; /node1/d; /node2/d' /etc/hosts
sudo sed -i '$a 10.0.0.10\tmaster.local\tmaster\n10.0.0.11\tnode1.local\tnode1\n10.0.0.12\tnode2.local\tnode2' /etc/hosts

