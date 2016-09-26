#DHCP config: 	
- /etc/dhcp/dhcpd.conf
- sudo service isc-dhcp-server restart

#DNS config: 	
- /etc/bind/db.acs
- sudo service bind9 restart

#Port forwarding:
- /etc/opt/forwards

#Script for NAT: 
- /usr/local/bin/iptables-config
- sudo iptables-config 
- (saves output to /etc/iptables/rules.v4)

#Interface config locations:
- /etc/default/isc-dhcp-server
- /etc/network/interfaces
- /etc/hosts
