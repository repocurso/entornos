#!/bin/bash

mkdir -p ~/curso/scripts && cd ~/curso/scripts

cat > ~/curso/scripts/start-minikube.sh << EOT
#!/bin/bash
sleep 30
minikube start 
kubectl config delete-context k8s-c2
kubectl config rename-context minikube k8s-c2
kubectl config use-context k8s-c1
EOT

chmod 777 ~/curso/scripts/start-minikube.sh

sudo sh -c 'cat > /etc/systemd/system/minikube.service << EOT
[Unit]
Description=Start Minikube
After=network.target docker.service autostart_vm@repository
Requires=autostart_vm@repository

[Service]
User=pue
Environment="PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
ExecStart=/home/pue/curso/scripts/start-minikube.sh
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOT'

sudo systemctl daemon-reload
sudo systemctl enable minikube.service
sudo systemctl start minikube.service

sudo reboot

