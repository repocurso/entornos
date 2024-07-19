#!/bin/bash

# Arrancar VMs de swarm
virsh shutdown swarm_worker02 --mode acpi 
virsh shutdown swarm_worker01 --mode acpi 
virsh shutdown swarm_manager --mode acpi 

