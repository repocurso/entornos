#!/bin/bash

# Arrancar VMs de swarm
virsh shutdown swarm-worker02 --mode acpi 
virsh shutdown swarm-worker01 --mode acpi 
virsh shutdown swarm-manager --mode acpi 
sleep 10
virsh start swarm-manager
virsh start swarm-worker01
virsh start swarm-worker02

