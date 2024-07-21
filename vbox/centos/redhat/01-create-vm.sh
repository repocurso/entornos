#!/bin/bash

export DIR="$HOME/curso/shared/centos"
mkdir -p $DIR && chmod 755 $DIR

cp Vagrantfile $DIR/Vagrantfile
cd $DIR
vagrant up  

