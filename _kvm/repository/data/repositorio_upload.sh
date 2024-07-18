#!/bin/bash

docker login -u admin -p container@13 repocurso:9091

for imagen in $(cat repositorio.list); do
 docker pull $imagen;
 docker tag $imagen repocurso:9091/$(basename $imagen);
 docker push repocurso:9091/$(basename $imagen);
 docker rmi $imagen;
 docker rmi repocurso:9091/$(basename $imagen);
 sleep 10;
done
docker logout repocurso:9091
