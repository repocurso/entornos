#!/bin/bash

vagrant up --provider=libvirt --no-parallel

# --- Renombrar VM (kvm/libvirt)
#virsh shutdown swarm_manager
#virsh shutdown swarm_worker01
#virsh shutdown swarm_worker02
#sleep 30
#virsh domrename swartu_ubuntu docker-ubuntu
#virsh start docker-ubuntu

