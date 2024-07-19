#!/bin/bash

# Arrancar VM de centos
virsh shutdown repository --mode acpi 
sleep 10
sudo virsh net-start vagrant-libvirt
sudo virsh net-start repository0
virsh start repository

