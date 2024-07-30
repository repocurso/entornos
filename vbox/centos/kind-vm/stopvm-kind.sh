#!/bin/bash

# Parar VMs de kind
VBoxManage controlvm kind acpipowerbutton 2> /dev/null
echo -n "Waiting for the VM to shutdown"
while [ "$(VBoxManage list runningvms | grep kind)" != "" ]; do echo -n "." ; sleep 5; done

echo ""
echo "**** VM kind stopped: $(date)"; echo ""



