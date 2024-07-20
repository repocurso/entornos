#!/bin/bash

# Arrancar VMs de swarm
virsh shutdown k8s_node1 --mode acpi 
virsh shutdown k8s_node2 --mode acpi 
virsh shutdown k8s_master --mode acpi 
sleep 30
virsh start k8s_master
virsh start k8s_node1
virsh start k8s_node2

