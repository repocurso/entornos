#!/bin/bash

# Arrancar VMs del entorno

sh stopvm-repository.sh
sh stopvm-centos.sh
sh stopvm-ubuntu.sh
sh stopvm-swarm.sh
sh stop-kind.sh
sh stop-minikube.sh
sh stopvm-k8s.sh

