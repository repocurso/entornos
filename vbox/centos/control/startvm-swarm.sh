#!/bin/bash

# Arrancar VMs de swarm
VBoxManage controlvm manager  acpipowerbutton 2> /dev/null
VBoxManage controlvm worker01 acpipowerbutton 2> /dev/null
VBoxManage controlvm worker02 acpipowerbutton 2> /dev/null
sleep 10
VBoxManage startvm manager  --type headless
VBoxManage startvm worker01 --type headless
VBoxManage startvm worker02 --type headless
