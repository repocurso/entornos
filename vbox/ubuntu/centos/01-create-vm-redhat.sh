#!/bin/bash

export DIR="$HOME/curso/shared/centos"
mkdir -p $DIR && chmod 777 $DIR

cp Vagrantfile.redhat $DIR/Vagrantfile
cd $DIR
vagrant up  

