#!/bin/bash

export ID_RSA_PUB=$(cat ~/.ssh/id_rsa.pub)
vagrant ssh -c "echo $ID_RSA_PUB | sudo tee -a /home/vagrant/.ssh/authorized_keys"

vagrant ssh -c "echo \"export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$ '\" | tee -a .bash_profile"

vagrant ssh -c "echo \"export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]# '\" | sudo tee -a /root/.bash_profile"



