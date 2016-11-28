# cluster-computing

[![Build Status](https://travis-ci.org/acswmu/cluster-computing.svg?branch=master)](https://travis-ci.org/acswmu/cluster-computing)
- Notes: https://docs.google.com/document/d/1ahgR-jfalc6UZaktGN78Ot6vkBdaZDw0PaNIx-NyMlU/edit?usp=sharing

## Build Requirements
- Ubuntu 16
- java-7-openjdk-amd64
- Scala 2.11.6
- sbt 0.13.11 
- Hadoop 2.7.2
- Spark 2.0.2

## Running
1. DHCP
2. Ansible
3. Hadoop
4. Spark
5. Ganglia

## Install Guide (do everything as root)

### Base Components
```bash
apt-get install rsync git build-essential vim
cd ~/
git clone https://github.com/acswmu/cluster-computing.git
echo "source /root/cluster-computing/.bash_aliases" >> ~/.bashrc
```

### Java
```bash
add-apt-repository ppa:openjdk-r/ppa
apt-get update
apt-get install openjdk-7-jdk
update-java-alternatives
```
### Scala
```bash
wget http://www.scala-lang.org/files/archive/scala-2.11.8.deb
dpkg -i scala-2.11.8.deb
apt-get update
apt-get install scala
wget https://dl.bintray.com/sbt/debian/sbt-0.13.11.deb
dpkg -i sbt-0.13.11.deb
apt-get update
apt-get install sbt
```

### Hadoop
Configuration file examples in configs/hadoop

#### Creating Hadoop User
```bash
adduser hduser
passwd hduser #input password for hduser here
su hduser
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys
ssh localhost
```
#### Setting Up Hadoop
```bash
 wget https://archive.apache.org/dist/hadoop/core/hadoop-2.4.1/hadoop-2.4.1.tar.gz
tar xzf hadoop-2.4.1.tar.gz
mv hadoop-2.4.1 /usr/local/hadoop
```






