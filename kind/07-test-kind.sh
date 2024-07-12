#!/bin/bash

docker login repocurso:9091 --username admin --password curso-k8s@20
docker run repocurso:9091/hello-world
docker images repocurso:9091/hello-world

crictl -r unix:///run/containerd/containerd.sock pull repocurso:9091/nginx
crictl -r unix:///run/containerd/containerd.sock images

