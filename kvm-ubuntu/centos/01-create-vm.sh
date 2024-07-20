#!/bin/bash

mkdir -p ~/curso/shared/centos/

vagrant up --provider=libvirt 

# --- Renombrar VM (kvm/libvirt)
virsh shutdown centos_centos 
sleep 10
virsh domrename centos_centos docker-centos
virsh start docker-centos 

