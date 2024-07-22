#!/bin/bash

# Arrancar VM de centos
VBoxManage controlvm docker-centos acpipowerbutton 2> /dev/null
sleep 10
VBoxManage startvm docker-centos --type headless

