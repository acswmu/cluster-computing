#!/bin/bash
newhost=$1
echo "Dont forget to update/create DDNS: https://www.duckdns.org"
oldhost=$(</etc/hostname)
echo "Changing ${oldhost} to ${newhost}"
hostname ${newhost}
sudo perl -pi -e "s/${oldhost}/${newhost}/g" /etc/hosts
sudo perl -pi -e "s/${oldhost}/${newhost}/g" /etc/hostname
sudo perl -pi -e "s/${oldhost}/${newhost}/g" /home/acsuser/duckdns/duck.sh
sudo service networking restart 
echo "please reboot"
