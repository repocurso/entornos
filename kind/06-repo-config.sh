#!/bin/bash

for node in c1-control-plane c1-worker c1-worker2; do
docker exec -u root -it --privileged $node /bin/bash -c 'cat << EOT | sh - 
echo "192.168.100.200 repocurso" >> /etc/hosts
echo {\"insecure-registries\": [\"192.168.100.200:9091\",\"repocurso:9091\"]} > /etc/docker/daemon.json
cat >> /etc/containerd/config.toml << EOF

[plugins."io.containerd.grpc.v1.cri".registry]
  config_path = ""
  [plugins."io.containerd.grpc.v1.cri".registry.auths]
  [plugins."io.containerd.grpc.v1.cri".registry.configs]
    [plugins."io.containerd.grpc.v1.cri".registry.configs."repocurso:9091".tls]
      insecure_skip_verify = true
    [plugins."io.containerd.grpc.v1.cri".registry.configs."repocurso:9091".auth]
      auth = "YWRtaW46Y3Vyc28tazhzQDIw"
  [plugins."io.containerd.grpc.v1.cri".registry.headers]
  [plugins."io.containerd.grpc.v1.cri".registry.mirrors]
    [plugins."io.containerd.grpc.v1.cri".registry.mirrors."repocurso:9091"]
      endpoint = ["http://repocurso:9091"]
EOF
systemctl restart docker
systemctl restart containerd
EOT';
done

