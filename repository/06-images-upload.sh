#!/bin/bash

# Upload imagenes

mkdir -p ./data && cd ./data

cat > repositorio.list << EOT
repocurso/alpine:3.20
repocurso/alpine:3.19
repocurso/alpine:latest
repocurso/app-on-two-ports:latest
repocurso/bash:latest
repocurso/busybox:latest
repocurso/busybox-k8s:latest
repocurso/cadvisor:latest
repocurso/cadvisor2:latest
repocurso/centos:8.4
repocurso/centos:7.9
repocurso/centos:latest
repocurso/ctop:latest
repocurso/debian:10
repocurso/debian:11
repocurso/docker:v1
repocurso/echoserver:1.10
repocurso/erase-una-vez-1:0.2.1
repocurso/erase-una-vez-2:0.1.0
repocurso/gb-frontend-amd64:v5
repocurso/glances:latest
repocurso/glances:latest-full
repocurso/goproxy-k8s:0.1
repocurso/grafana:latest
repocurso/hello-app:1.0
repocurso/hello-app:2.0
repocurso/hello-world:latest
repocurso/helloworld-node-microservice:latest
repocurso/httpd:latest
repocurso/jenkins:latest
repocurso/k8s-demo:latest
repocurso/liveness-k8s:latest
repocurso/mariadb:10.0
repocurso/memcached:1.6.7
repocurso/memcached:1.6.8
repocurso/memcached:1.6.9
repocurso/memcached:latest
repocurso/mensaje:1.0.0
repocurso/message-ipc:latest
repocurso/mysql:latest
repocurso/netshoot:latest
repocurso/nexus3:latest
repocurso/nginx:1.7.8
repocurso/nginx:1.9.1
repocurso/nginx:1.14.2
repocurso/nginx:1.24.0-alpine-slim
repocurso/nginx:latest
repocurso/nginx:v1
repocurso/nginx:v2
repocurso/nginxhello:1.12.1
repocurso/nginx-unprivileged:latest
repocurso/perl:5.34.0
repocurso/portainer:latest
repocurso/portainer-agent:2.19.5
repocurso/prometheus:latest
repocurso/python:3.7-alpine
repocurso/rancher:latest
repocurso/redis:alpine
repocurso/redis:3.0.6
repocurso/redis:3.0.7
repocurso/redis:latest
repocurso/registry:latest
repocurso/rockylinux-systemd:latest
repocurso/simpleservice:0.5.0
repocurso/stress1:latest
repocurso/stress2:latest
repocurso/timetable:latest
repocurso/ubuntu:16.04
repocurso/ubuntu:18.04
repocurso/ubuntu:20.04
repocurso/ubuntu:22.04
repocurso/ubuntu:latest
repocurso/ubuntu-slim:0.1
repocurso/web-app:1.0.1
repocurso/whalesay:latest
EOT

# -----------------------------------------------------------------

cat > repositorio_upload.sh << EOT
#!/bin/bash

docker login -u admin -p container@13 repocurso:9091

for imagen in \$(cat repositorio.list); do
 docker pull \$imagen;
 docker tag \$imagen repocurso:9091/\$(basename \$imagen);
 docker push repocurso:9091/\$(basename \$imagen);
 docker rmi \$imagen;
 docker rmi repocurso:9091/\$(basename \$imagen);
 sleep 5;
done
docker logout repocurso:9091
EOT

chmod +x repositorio_upload.sh

./repositorio_upload.sh

