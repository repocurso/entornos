#!/bin/bash

echo Repository Demo...
ssh vagrant@ubuntu sh -c 'cat << EOT | sh -
echo -n "repocurso:9091 Connecting: "
docker login 192.168.100.200:9091 --username admin --password container@13 2> /dev/null
echo -n "repocurso:9091 Connecting: "
docker login repocurso:9091 --username admin --password container@13 2> /dev/null
echo
docker pull --quiet 192.168.100.200:9091/hello-world 
docker run --rm --quiet repocurso:9091/hello-world
docker images
docker rmi 192.168.100.200:9091/hello-world repocurso:9091/hello-world 2> /dev/null
echo
docker images
docker logout 192.168.100.200:9091
docker logout repocurso:9091
EOT'

