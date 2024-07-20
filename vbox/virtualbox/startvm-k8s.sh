#!/bin/bash

# Arrancar VMs de k8s
VBoxManage controlvm master acpipowerbutton
VBoxManage controlvm node1  acpipowerbutton
VBoxManage controlvm node2  acpipowerbutton
sleep 10
VBoxManage startvm master --type headless
VBoxManage startvm node1  --type headless
VBoxManage startvm node2  --type headless
