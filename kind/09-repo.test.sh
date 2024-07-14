#!/bin/bash

docker exec -u root -it --privileged c1-control-plane /bin/bash -c 'cat << EOT | sh -
kubectl create deployment deploy1 --image=repocurso:9091/nginx --replicas 3
kubectl get pods -owide -l app=deploy1
sleep 10
kubectl get pods -owide -l app=deploy1
kubectl delete deployment deploy1
EOT'
for node in c1-control-plane c1-worker c1-worker2; do
docker exec -u root -it --privileged $node /bin/bash -c 'cat << EOT | sh -
echo "========== $HOSTNAME =========="
crictl -r unix:///run/containerd/containerd.sock images | grep -i repocurso
crictl -r unix:///run/containerd/containerd.sock rmi repocurso:9091/nginx
crictl -r unix:///run/containerd/containerd.sock images | grep -i repocurso
EOT';
done

