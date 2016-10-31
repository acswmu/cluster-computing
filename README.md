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

## Install Guide

### Java
```bash
sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt-get update
sudo apt-get install openjdk-7-jdk
sudo update-java-alternatives
```
### Scala
```bash
sudo wget http://www.scala-lang.org/files/archive/scala-2.11.8.deb
sudo dpkg -i scala-2.11.8.deb
sudo apt-get update
sudo apt-get install scala
wget https://dl.bintray.com/sbt/debian/sbt-0.13.11.deb
sudo dpkg -i sbt-0.13.11.deb
sudo apt-get update
sudo apt-get install sbt
```
