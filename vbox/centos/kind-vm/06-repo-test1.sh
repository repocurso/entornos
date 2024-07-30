#!/bin/bash

ssh vagrant@kind sh -c 'cat > /shared/repo-test1.sh << EOT 
#!/bin/bash
echo "========== \$HOSTNAME =========="
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
EOT'

ssh vagrant@kind "for node in kind-control-plane kind-worker kind-worker2; do docker exec -u root -i --privileged \$node /bin/bash -c 'sh /shared/repo-test1.sh'; done"

echo "**** test1 repository finalized: $(date)"; echo ""
