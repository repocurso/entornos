#!/bin/bash

echo "Restart=always Configuring"
docker update --restart=always c1-control-plane 
docker update --restart=always c1-worker
docker update --restart=always c1-worker2

echo

echo "Cluster Starting"
docker start c1-control-plane
docker start c1-worker
docker start c1-worker2

