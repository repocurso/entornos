#!/bin/bash

cat << EOF | sudo sh -
cp .bashrc .bashrc.org
echo '
function fssh() {
    echo "Debug: \$@"
    if [[ "\$1" =~ ^(kind-control-plane|kind-worker|kind-worker2)$ ]]; then
        if [ \$# -eq 1 ]; then
          docker exec -u vagrant -w /home/vagrant -it "\$1" /bin/bash
        else
          node="\$1"; shift
          echo "Debug: node=\$node, args=\$@"
          docker exec -u vagrant -w /home/vagrant -it "\$node" "\$@"
        fi
    else
        ssh "\$@"
    fi
}

alias ssh=fssh' >> .bashrc
EOF

source .bashrc

echo "**** SSH function configured: $(date)"; echo ""
