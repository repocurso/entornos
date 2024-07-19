#!/bin/bash

# Arranque automático VM

sudo virsh net-autostart vagrant-libvirt
sudo virsh net-autostart repository0
sudo virsh autostart repository_repository 

virsh net-list --all

virsh shutdown repository_repository
virsh domrename repository_repository repository

sudo reboot

