#!/bin/bash

if [ ! -f ~/curso/entornos/host/data/config.json ]; then echo "No existe el archivo de claves"; exit; fi
export REPO_AUTH=$(jq -r '.auths["repocurso:9091"].auth' ~/curso/entornos/host/data/config.json)

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

