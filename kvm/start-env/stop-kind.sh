#!/bin/bash

echo "Restart=no Configuring"
docker update --restart=no c1-control-plane 
docker update --restart=no c1-worker
docker update --restart=no c1-worker2

echo

echo "Cluster Stopping"
docker stop c1-control-plane
docker stop c1-worker
docker stop c1-worker2

