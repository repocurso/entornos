#!/bin/bash

# Arrancar VMs de swarm
VBoxManage controlvm worker01 acpipowerbutton
VBoxManage controlvm worker02 acpipowerbutton
VBoxManage controlvm manager acpipowerbutton


