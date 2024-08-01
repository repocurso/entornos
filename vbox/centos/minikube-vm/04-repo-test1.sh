#!/bin/bash

for node in minikube minikube-m02 minikube-m03; do
minikube ssh -n $node '
echo "========== $HOSTNAME =========="
echo -n "192.168.100.200:9091 Connecting: "
docker login 192.168.100.200:9091 --username admin --password container@13 2> /dev/null
echo -n "repocurso:9091 Connecting: "
docker login repocurso:9091 --username admin --password container@13 2> /dev/null
docker pull --quiet 192.168.100.200:9091/hello-world 
docker run --rm --quiet repocurso:9091/hello-world
docker images 
docker rmi 192.168.100.200:9091/hello-world repocurso:9091/hello-world 2> /dev/null
echo
docker images
docker logout 192.168.100.200:9091
docker logout repocurso:9091
exit'
done

echo ""; echo "**** test1 repository finalized: $(date)"; echo ""
