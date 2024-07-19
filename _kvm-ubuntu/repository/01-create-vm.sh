#!/bin/bash

mkdir -p ~/curso/shared/repository/

vagrant up --provider=libvirt 

# --- Renombrar VM (kvm/libvirt)
virsh shutdown repository_repository
sleep 10
virsh domrename repository_repository repository
virsh start repository

