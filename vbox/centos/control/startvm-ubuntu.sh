#!/bin/bash

# Arrancar VM de ubuntu
VBoxManage controlvm docker-ubuntu acpipowerbutton 2> /dev/null
sleep 10
VBoxManage startvm docker-ubuntu --type headless

