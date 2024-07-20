virsh net-destroy red-entornos
virsh net-undefine red-entornos

sudo virsh net-define red-entornos.xml
sudo virsh net-autostart red-entornos
sudo virsh net-start red-entornos
