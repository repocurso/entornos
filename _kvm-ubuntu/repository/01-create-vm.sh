#!/bin/bash

vagrant up --provider=libvirt 

# --- Renombrar VM (kvm/libvirt)
virsh shutdown repository_repository
virsh domrename repository_repository repository
virsh start repository

