#!/bin/bash

cp ~/curso/entornos/host/data/config.json .

export CRED1=$(cat config.json | head -n1)

docker exec -u root -it --privileged -e CRED=$CRED1 c1-control-plane /bin/bash -c 'cat << EOT | sh -
echo "$CRED" ; sleep 6
echo $CRED | tee /tmp/config.json
kubectl create secret generic registry-credential \
--from-file=.dockerconfigjson="/tmp/config.json" \
--type=kubernetes.io/dockerconfigjson
rm -f config.json
EOT'
#kubectl patch serviceaccount default -p \'{"imagePullSecrets": [{"name": "registry-credential"}]}\'
