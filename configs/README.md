#Configs

## DHCP
- db.acs -- DNS bind list
- dhcpd.conf -- configuration file for ISC dhcpd
- forwards -- Port forwarding definitions
- hosts -- Example of Linux hosts file
- interfaces --  Describes the network interfaces available on your system
- iptables-config -- Script to setup iptables firewall
- isc-dhcp-server -- Defaults for isc-dhcp-server initscript

## Ansible
- ansible.cfg -- Config file for Ansible
- hosts -- Contains host groups for Ansible

## Ganglia
- gmetad.conf -- Ganglia Meta Daemon configuration file
- gmond.conf -- Used to configure the ganglia monitoring daemon on master
- gmondCLIENT.conf -- Used to configure the ganglia monitoring daemon on slaves

## Hadoop
- core-site.xml -- Informs Hadoop daemon where NameNode runs in the cluster.
- yarn-site.xml -- Configurations for YARN Resource Manager that runs in a master node
- hdfs-site.xml -- Contains the configuration settings for HDFS daemons
- mapred-site.xml -- Configurations for Mapreduce that runs in a master node
- slaves -- List of slave nodes in the cluster
- hadoop-env.sh --  Contains some environment variable settings used by Hadoop

## Hive
- hive-default.xml -- Default hive configs
- hive-env.sh -- Contains some environment variable settings used by Hive
- jpox.properties -- Connects Hive to Derby

## Spark
- error.log4j.properties -- Sets log level to error
- info.log4j.properties -- Sets log level to info
- mapred-site.xml -- Configurations for Mapreduce that runs in a master node
- slaves -- List of slave nodes in the cluster
- master -- List of master nodes in the cluster
- spark-env.sh --  Contains some environment variable settings used by Spark
