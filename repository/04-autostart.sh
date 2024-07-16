#!/bin/bash

# Arranque automático VM

sudo usermod -a -G vboxusers $USER

echo -e "VBOXAUTOSTART_DB=/etc/vbox\nVBOXAUTOSTART_CONFIG=/etc/vbox/vbox.cfg" | sudo tee /etc/default/virtualbox
echo -e "default_policy = deny\npue = {\nallow = true\n}" | sudo tee /etc/vbox/vbox.cfg

sudo chgrp vboxusers /etc/vbox
sudo chmod 1775 /etc/vbox

# sudo reboot

# -----------------------------------------------------------------

echo "[Unit]
Description=AutoStart VM %i
After=network.target vboxdrv.service
Before=runlevel2.target shutdown.target

[Service]
User=pue
Group=vboxusers
Type=forking
TimeoutSec=5min
IgnoreSIGPIPE=no
KillMode=process
GuessMainPID=no
RemainAfterExit=yes
ExecStart=/usr/bin/VBoxManage startvm %i --type headless
ExecStop=/usr/bin/VBoxManage controlvm %i acpipowerbutton

[Install]
WantedBy=multi-user.target" | sudo tee /etc/systemd/system/autostart_vm@.service

# -----------------------------------------------------------------

VBoxManage setproperty autostartdbpath /etc/vbox
VBoxManage list vms
VBoxManage controlvm repository acpipowerbutton
sleep 10
VBoxManage modifyvm repository --autostart-enabled on

sudo systemctl daemon-reload
sudo systemctl enable autostart_vm@repository
sudo systemctl status autostart_vm@repository -l
sudo systemctl start autostart_vm@repository
sudo systemctl status autostart_vm@repository -l
sudo systemctl stop autostart_vm@repository
sudo systemctl status autostart_vm@repository -l

sudo reboot

