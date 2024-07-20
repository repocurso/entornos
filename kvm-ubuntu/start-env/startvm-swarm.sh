#!/bin/bash

# Arrancar VMs de swarm
virsh shutdown swarm_worker02 --mode acpi 
virsh shutdown swarm_worker01 --mode acpi 
virsh shutdown swarm_manager --mode acpi 
sleep 10
virsh start swarm_manager
virsh start swarm_worker01
virsh start swarm_worker02

