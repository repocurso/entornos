#!/bin/bash

VBoxManage list vms 
for vm in $(vboxmanage list vms | cut -f1 -d" "); do echo $vm; echo "VBoxManage controlvm $vm poweroff 2> /dev/null"|sh -; sleep 10; echo VBoxManage modifyvm $vm --vrde off|sh -; echo VBoxManage modifyvm $vm --graphicscontroller vmsvga|sh -; done

