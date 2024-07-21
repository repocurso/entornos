#!/bin/bash

# Arrancar VM de ubuntu
VBoxManage controlvm docker-ubuntu acpipowerbutton
sleep 10
VBoxManage startvm docker-ubuntu --type headless

