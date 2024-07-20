#!/bin/bash

# Arrancar VM de centos
virsh shutdown docker-centos --mode acpi 
sleep 10
sudo virsh net-start vagrant-libvirt
sudo virsh net-start centos0
virsh start docker-centos
 
