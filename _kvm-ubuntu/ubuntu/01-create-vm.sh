#!/bin/bash

vagrant up --provider=libvirt 

# --- Renombrar VM (kvm/libvirt)
virsh shutdown ubuntu_ubuntu        
virsh domrename ubuntu_ubuntu docker-ubuntu
virsh start docker-ubuntu

