#!/bin/bash

# Arrancar VMs de k8s
virsh shutdown k8s-node2 --mode acpi 
virsh shutdown k8s-node1 --mode acpi 
virsh shutdown k8s-master --mode acpi 
sleep 10
virsh start k8s-master
virsh start k8s-node1
virsh start k8s-node2

