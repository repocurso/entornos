#!/bin/bash

kubectl config use-context k8s-c1
kubectl create deployment deploy1 --image=repocurso:9091/nginx --replicas 3
kubectl get pods -owide -l app=deploy1
kubectl wait --for=condition=available --timeout=300s deployment/deploy1
kubectl get pods -owide -l app=deploy1
kubectl delete deployment deploy1
while kubectl get pods -l app=deploy1 -o jsonpath='{.items[*].status.phase}' | grep -q 'Running\|Pending\|ContainerCreating'; do
  echo -n "."
  sleep 2
done

ssh vagrant@kind sh -c 'cat > /shared/repo-test2.sh << EOT 
#!/bin/bash
echo "========== \$HOSTNAME =========="
crictl -r unix:///run/containerd/containerd.sock images | grep -i repocurso
crictl -r unix:///run/containerd/containerd.sock rmi repocurso:9091/nginx
crictl -r unix:///run/containerd/containerd.sock images | grep -i repocurso
EOT'

ssh vagrant@kind "for node in kind-control-plane kind-worker kind-worker2; do docker exec -u root -i --privileged \$node /bin/bash -c 'sh /shared/repo-test2.sh'; done"

echo "**** test2 repository finalized: $(date)"; echo ""


