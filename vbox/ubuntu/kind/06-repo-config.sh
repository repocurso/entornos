#!/bin/bash

if [ ! -f ~/curso/shared/data/config.json ]; then echo "No existe el archivo de claves"; exit; fi
export REPO_AUTH=$(jq -r '.auths["repocurso:9091"].auth' ~/curso/shared/data/config.json)

for node in c1-control-plane c1-worker c1-worker2; do
docker exec -u root -it --privileged -e REPO_AUTH=$REPO_AUTH $node /bin/bash -c 'cat << EOT | sudo sh - 
echo "========== $HOSTNAME =========="
grep -v "repocurso" /etc/hosts > /tmp/hosts.temp ; cat /tmp/hosts.temp > /etc/hosts ; rm /tmp/hosts.temp
echo "192.168.100.200\trepocurso.local\trepocurso" >> /etc/hosts
echo {\"insecure-registries\": [\"192.168.100.200:9091\",\"repocurso:9091\"]} > /etc/docker/daemon.json
grep plugins.\"io.containerd.grpc.v1.cri\".registry /etc/containerd/config.toml
result="\$?"; echo \$result
if [ \$result -ne 0 ]; then 
cat >> /etc/containerd/config.toml << EOF

[plugins."io.containerd.grpc.v1.cri".registry]
  config_path = ""
  [plugins."io.containerd.grpc.v1.cri".registry.auths]
  [plugins."io.containerd.grpc.v1.cri".registry.configs]
    [plugins."io.containerd.grpc.v1.cri".registry.configs."repocurso:9091".tls]
      insecure_skip_verify = true
    [plugins."io.containerd.grpc.v1.cri".registry.configs."repocurso:9091".auth]
      auth = "$REPO_AUTH"
  [plugins."io.containerd.grpc.v1.cri".registry.headers]
  [plugins."io.containerd.grpc.v1.cri".registry.mirrors]
    [plugins."io.containerd.grpc.v1.cri".registry.mirrors."repocurso:9091"]
      endpoint = ["http://repocurso:9091"]
EOF
else
  export OLD_AUTH="$(grep "auth =" /etc/containerd/config.toml | cut -f2 -d"=" | xargs)"
  echo R:$REPO_AUTH: O:\$OLD_AUTH:
  sed -i "s/\$OLD_AUTH/$REPO_AUTH/" /etc/containerd/config.toml
fi
systemctl restart docker
systemctl restart containerd
EOT';
done

kubectl config use-context k8s-c1

kubectl delete configmaps init-hosts-script -n kube-system

cat << EOT | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  name: init-hosts-script
  namespace: kube-system
data:
  init-hosts.sh: |
    #!/bin/sh
    REPOCURSO="192.168.100.200 repocurso"
    if ! grep -q "192.168.100.200 repocurso" /etc/hosts; then
      echo "192.168.100.200 repocurso" >> /etc/hosts
    fi
EOT

kubectl delete daemonset update-hosts-daemonset -n kube-system

cat << EOT | kubectl apply -f -
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: update-hosts-daemonset
  namespace: kube-system  
  labels:
    app: update-hosts
spec:
  selector:
    matchLabels:
      app: update-hosts
  template:
    metadata:
      labels:
        app: update-hosts
    spec:
      containers:
      - name: update-hosts
        image: busybox  
        command:
        - "/bin/sh"
        - "-c"
        - "cp /scripts/init-hosts.sh /host/init-hosts.sh && chroot /host sh /init-hosts.sh"
        volumeMounts:
        - name: script-volume
          mountPath: /scripts
        - name: host-root
          mountPath: /host
        securityContext:
          privileged: true
      volumes:
      - name: script-volume
        configMap:
          name: init-hosts-script  
      - name: host-root
        hostPath:
          path: /
          type: Directory
      tolerations:
      - key: "node.kubernetes.io/not-ready"
        operator: "Exists"
        effect: "NoExecute"
      - key: "node.kubernetes.io/unreachable"
        operator: "Exists"
        effect: "NoExecute"
      - key: "node-role.kubernetes.io/control-plane"
        operator: "Exists"
        effect: "NoSchedule"
EOT


