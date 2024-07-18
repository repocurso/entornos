#!/bin/bash

vagrant up --provider=libvirt 

# --- Renombrar VM (kvm/libvirt)
virsh shutdown centos_centos 
virsh domrename centos_centos docker-centos
virsh start docker-centos 

