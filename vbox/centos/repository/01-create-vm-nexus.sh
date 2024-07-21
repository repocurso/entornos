#!/bin/bash

export DIR="$HOME/curso/shared/repository"
mkdir -p $DIR && chmod 755 $DIR

cp Vagrantfile.nexus $DIR/Vagrantfile
cd $DIR
vagrant up  

