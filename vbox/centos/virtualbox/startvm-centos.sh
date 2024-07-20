#!/bin/bash

# Arrancar VM de centos
VBoxManage controlvm docker-centos acpipowerbutton
sleep 10
VBoxManage startvm docker-centos --type headless

