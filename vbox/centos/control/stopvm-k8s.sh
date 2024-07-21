#!/bin/bash

# Arrancar VMs de k8s
VBoxManage controlvm node1 acpipowerbutton
VBoxManage controlvm node2 acpipowerbutton
VBoxManage controlvm master acpipowerbutton


