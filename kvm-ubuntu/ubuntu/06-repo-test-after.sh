#!/bin/bash

docker login repocurso:9091 --username admin --password container@13
docker run --rm repocurso:9091/hello-world
docker rmi repocurso:9091/hello-world
docker logout repocurso:9091
