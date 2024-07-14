#!/bin/bash

mkdir -p ~/curso/scripts && cd ~/curso/scripts

cat > ~/curso/scripts/start-minikube.sh << EOT
#!/bin/bash
sleep 30
minikube start 
EOT

chmod 777 ~/curso/scripts/start-minikube.sh

sudo sh -c 'cat > /etc/systemd/system/start-minikube.service << EOT
[Unit]
Description=Start Minikube
After=network.target docker.service autostart_vm@repository
Requires=autostart_vm@repository

[Service]
User=pue
Environment="PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
ExecStart=/home/pue/curso/scripts/start-minikube.sh

[Install]
WantedBy=multi-user.target
EOT'

sudo systemctl daemon-reload
sudo systemctl enable start-minikube.service
sudo systemctl start start-minikube.service

sudo reboot

