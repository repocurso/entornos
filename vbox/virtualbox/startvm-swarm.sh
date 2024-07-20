#!/bin/bash

# Arrancar VMs de swarm
VBoxManage controlvm manager  acpipowerbutton
VBoxManage controlvm worker01 acpipowerbutton
VBoxManage controlvm worker02 acpipowerbutton
sleep 10
VBoxManage startvm manager  --type headless
VBoxManage startvm worker01 --type headless
VBoxManage startvm worker02 --type headless
