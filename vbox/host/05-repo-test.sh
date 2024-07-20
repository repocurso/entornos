#!/bin/bash

docker login repocurso:9091 --username admin --password container@13
docker login 192.168.100.200:9091 --username admin --password container@13
echo
docker pull --quiet 192.168.100.200:9091/hello-world
docker run --rm --quiet repocurso:9091/hello-world
docker images 
docker rmi repocurso:9091/hello-world 192.168.100.200:9091/hello-world > /dev/null
echo
docker images
echo
docker logout repocurso:9091
docker logout 192.168.100.200:9091
