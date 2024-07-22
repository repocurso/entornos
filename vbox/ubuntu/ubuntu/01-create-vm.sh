#!/bin/bash

export DIR="$HOME/curso/shared/ubuntu"
mkdir -p $DIR && chmod 755 $DIR

cp Vagrantfile $DIR/Vagrantfile
cd $DIR
vagrant up  

