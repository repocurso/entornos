#!/bin/bash

for node in c1-control-plane c1-worker c1-worker2; do
docker exec -u root -it --privileged $node /bin/bash -c 'cat << EOT | sh -
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
# ----------
crictl -r unix:///run/containerd/containerd.sock pull repocurso:9091/nginx
crictl -r unix:///run/containerd/containerd.sock images 
crictl -r unix:///run/containerd/containerd.sock rmi repocurso:9091/nginx
crictl -r unix:///run/containerd/containerd.sock images
EOT';
done
