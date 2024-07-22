#!/bin/bash

# Arrancar VMs de k8s
VBoxManage controlvm master acpipowerbutton 2> /dev/null
VBoxManage controlvm node1  acpipowerbutton 2> /dev/null
VBoxManage controlvm node2  acpipowerbutton 2> /dev/null
sleep 10
VBoxManage startvm master --type headless
VBoxManage startvm node1  --type headless
VBoxManage startvm node2  --type headless
