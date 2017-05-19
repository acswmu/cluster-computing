cd /root/cluster-computing/configs/DHCP
mkdir $1
cd $1
cp -rfv /etc/dhcp/dhcpd.conf .
cp -rfv /etc/bind/db.* .
cp -rfv /etc/opt/forwards .
cp -rfv /usr/local/bin/iptables-config .
cp -rfv /etc/network/interfaces .
cp -rfv /etc/hosts .
