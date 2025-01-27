#!/bin/bash

echo '{  "insecure-registries": ["repocurso:9091"]  }' | sudo tee /etc/docker/daemon.json
sudo systemctl restart docker
