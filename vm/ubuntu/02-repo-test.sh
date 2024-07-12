#!/bin/bash

docker login repocurso:9091 --username admin --password curso-k8s@20
docker run --rm repocurso:9091/hello-world
docker rmi repocurso:9091/hello-world
docker logout repocurso:9091
