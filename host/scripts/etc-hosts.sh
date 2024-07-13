#!/bin/bash

echo "192.168.100.200 repocurso" >> /etc/hosts
sed -i -e '$a10.100.199.200  manager' -e '$a10.100.199.201  worker01' -e '$a10.100.199.202  worker02' /etc/hosts
sed -i -e '$a10.0.0.10       master'  -e '$a10.0.0.11       node1'    -e '$a10.0.0.12       node2'    /etc/hosts

