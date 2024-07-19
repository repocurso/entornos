#!/bin/bash

# Arrancar VM de ubuntu
virsh shutdown docker-ubuntu --mode acpi 
sleep 10
sudo virsh net-start vagrant-libvirt
sudo virsh net-start ubuntu0
virsh start docker-ubuntu

