#!/bin/bash

# Arrancar VMs del entorno
sh startvm-repository.sh
sh startvm-centos.sh
sh startvm-centos.sh
sh startvm-ubuntu.sh
sh startvm-swarm.sh
sh startvm-k8s.sh

