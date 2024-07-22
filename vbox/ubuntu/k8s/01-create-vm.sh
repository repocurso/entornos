#!/bin/bash

export DIR="$HOME/curso/shared/k8s"
mkdir -p $DIR && chmod 755 $DIR

cp Vagrantfile $DIR/Vagrantfile
cp settings.yaml $DIR/settings.yaml
cp -r scripts/ $DIR/scripts/
cd $DIR
vagrant up 
