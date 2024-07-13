#!/bin/bash

for node in manager worker01 worker02; do
ssh vagrant@$node sh -c 'cat << EOT | sh -
docker login repocurso:9091 --username admin --password curso-k8s@20
docker run --rm repocurso:9091/hello-world
docker images repocurso:9091/hello-world
docker rmi repocurso:9091/hello-world
docker logout repocurso:9091 
EOT';
done

ssh vagrant@manager sh -c 'cat << EOT | sh -
docker login repocurso:9091 --username admin --password curso-k8s@20
docker service create --name webserver --replicas 3 --with-registry-auth repocurso:9091/nginx:latest
docker service ps webserver
docker service rm webserver
docker logout repocurso:9091
EOT'

sleep 5

for node in manager worker01 worker02; do
ssh vagrant@$node sh -c 'cat << EOT | sh -
docker images
docker rmi $(docker images -q repocurso:9091/nginx)
docker images
EOT';
done
