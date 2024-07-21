#!/bin/bash

scp data/CentOS-Base.repo vagrant@redhat:~/CentOS-Base.repo
ssh vagrant@redhat sh -c 'cat << EOT | sudo sh -
mv -f /etc/yum.repos.d/*.repo /tmp/
cp /home/vagrant/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo
yum clean all
yum makecache
yum repolist
yum update -y
EOT'

