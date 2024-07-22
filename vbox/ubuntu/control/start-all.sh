#!/bin/bash

# Arrancar VMs del entorno

sh startvm-repository.sh
sh startvm-centos.sh
sh startvm-ubuntu.sh
sh startvm-swarm.sh
sh start-kind.sh
sh start-minikube.sh
sh startvm-k8s.sh

