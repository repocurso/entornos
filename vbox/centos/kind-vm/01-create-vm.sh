#!/bin/bash

export DIR="$HOME/curso/shared/kind"
mkdir -p $DIR && chmod 755 $DIR

cp Vagrantfile $DIR/Vagrantfile
cp -r scripts/ $DIR/scripts/
cd $DIR
vagrant up 
