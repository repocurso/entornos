#!/bin/bash

# Arrancar VM de repository
VBoxManage controlvm repository acpipowerbutton 2> /dev/null
sleep 10
VBoxManage startvm repository --type headless

