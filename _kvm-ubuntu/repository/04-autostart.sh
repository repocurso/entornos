#!/bin/bash

# Arranque automático VM

sudo virsh net-autostart vagrant-libvirt
sudo virsh net-autostart red-entornos
sudo virsh autostart repository 

virsh net-list --all
virsh list --all

#virsh shutdown repository_repository
#virsh domrename repository_repository repository

sudo reboot

