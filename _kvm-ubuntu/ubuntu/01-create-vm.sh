#!/bin/bash

mkdir -p ~/curso/shared/ubuntu/

vagrant up --provider=libvirt 

# --- Renombrar VM (kvm/libvirt)
virsh shutdown ubuntu_ubuntu        
sleep 30
virsh domrename ubuntu_ubuntu docker-ubuntu
virsh start docker-ubuntu

