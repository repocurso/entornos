#!/bin/bash

# Arrancar VM de kind
VBoxManage controlvm kind acpipowerbutton 2> /dev/null
echo -n "Waiting for the VM to shutdown"
while [ "$(VBoxManage list runningvms | grep kind)" != "" ]; do echo -n "." ; sleep 5; done
echo ""
VBoxManage startvm kind --type headless

# Configurar tunel SSH

VM_IP="192.168.100.150"
VM_SSH_PORT="22"
LOCAL_PORT="6443"
REMOTE_PORT="6443"
SSH_USER="vagrant"
HOST_USER="pue"
HOST_GROUP="pue"
LOG_FILE="/var/log/ssh-tunnel.log" 

sudo rm -f $LOG_FILE
sudo touch $LOG_FILE
sudo chown $HOST_USER:$HOST_GROUP $LOG_FILE
sudo chmod 644 $LOG_FILE

echo -e -n "\nWaiting for the VM to be available" | tee -a $LOG_FILE
while ! nc -z "$VM_IP" "$VM_SSH_PORT"; do
    echo -n "." | tee -a $LOG_FILE
    sleep 5
done

if pgrep -f "ssh -f -L $LOCAL_PORT:localhost:$REMOTE_PORT $SSH_USER@$VM_IP" > /dev/null; then
    echo -e "\nThe SSH tunnel is now active" | tee -a $LOG_FILE
    echo "/usr/bin/ssh -f -L $LOCAL_PORT:localhost:$REMOTE_PORT $SSH_USER@$VM_IP -N" >> $LOG_FILE 2>&1
    exit 0
fi

echo -e "\nVM available. Starting SSH tunnel..." | tee -a $LOG_FILE
/usr/bin/ssh -f -L "$LOCAL_PORT:localhost:$REMOTE_PORT" "$SSH_USER@$VM_IP" -N >> $LOG_FILE 2>&1
if [ $? -eq 0 ]; then
    echo "SSH tunnel successfully initiated" | tee -a $LOG_FILE
    echo "/usr/bin/ssh -f -L $LOCAL_PORT:localhost:$REMOTE_PORT $SSH_USER@$VM_IP -N" >> $LOG_FILE 2>&1
else
    echo "Error starting SSH tunnel. Check $LOG_FILE for details" | tee -a $LOG_FILE
fi

echo "**** VM kind started: $(date)"; echo ""
