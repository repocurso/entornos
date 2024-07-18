mkdir -p ~/.minikube/files/etc && cd ~/.minikube/files/etc

cat > hosts << EOT
127.0.0.1       localhost
::1             localhost   ip6-localhost ip6-loopback
fe00::0         ip6-localnet
ff00::0         ip6-mcastprefix
ff02::1         ip6-allnodes
ff02::2         ip6-allrouters
192.168.49.2    minikube
192.168.49.3    minikube-m02
192.168.49.4    minikube-m03
192.168.100.200 repocurso
EOT
