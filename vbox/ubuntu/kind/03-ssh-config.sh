#!/bin/bash

cd
cp .bashrc .bashrc.org

cat >> .bashrc << EOT
function fssh() {
    if [[ "\$1" =~ ^(c1-control-plane|c1-worker|c1-worker2)$ ]]; then
        if [ \$# -eq 1 ]; then
          docker exec -u user1 -w /home/user1 -it "\$1" /bin/bash
        else
          node="\$1"; shift
          docker exec -u user1 -w /home/user1 -it "\$node" "\$@"
        fi
    else
        ssh "\$@"
    fi
}

alias ssh=fssh
EOT

source ~/.bashrc
