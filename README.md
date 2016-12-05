# cluster-computing

- Notes: https://docs.google.com/document/d/1ahgR-jfalc6UZaktGN78Ot6vkBdaZDw0PaNIx-NyMlU/edit?usp=sharing

## Build Requirements
- Ubuntu 16
- java-7-openjdk-amd64
- Scala 2.10.4
- sbt 0.13.11
- Maven 3.3.9
- Hadoop 2.4.1
- Spark 1.6.4
- R 3.2.*

### Running
1. DHCP
2. Ansible
3. Hadoop
4. Spark
5. Ganglia

## Install Guide (run as root unless specified)

### Base Components
```bash
apt-get update
apt-get install rsync git build-essential software-properties-common vim libssl-dev libcurl4-gnutls-dev cmake r-base r-base-dev zlib1g-dev libcurl4-openssl-dev pandoc
cd ~/
git clone https://github.com/acswmu/cluster-computing.git
echo "source /root/cluster-computing/.bash_aliases" >> ~/.bashrc
chmod 711 /root
```

- Java
```bash
add-apt-repository ppa:openjdk-r/ppa
apt-get update
apt-get install openjdk-7-jdk
update-java-alternatives
wget https://archive.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
tar xzf apache-maven-3.3.9-bin.tar.gz
mv apache-maven-3.3.9 /usr/local/maven
```

- Scala
```bash
wget http://www.scala-lang.org/files/archive/scala-2.10.4.deb
dpkg -i --force-overwrite scala-2.10.4.deb
wget https://dl.bintray.com/sbt/debian/sbt-0.13.11.deb
dpkg -i sbt-0.13.11.deb
apt-get update
apt-get install sbt
```

### Hadoop installation From Source
Configuration file examples in configs/hadoop

- Creating Hadoop User
```bash
groupadd hadoop
adduser hadoop hduser
passwd hduser #input password for hduser here
chown -R hduser:hadoop /root/cluster-computing
sudo -i -u hduser echo "source /root/cluster-computing/.bash_aliases" >> ~/.bashrc
sudo -i -u hduser ssh-keygen -t rsa
sudo -i -u hduser cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
sudo -i -u hduser chmod 0600 ~/.ssh/authorized_keys
sudo -i -u hduser ssh localhost
```

- Setting up Hadoop 
```bash
wget https://github.com/google/protobuf/releases/download/v2.5.0/protobuf-2.5.0.tar.gz
tar xzf protobuf-2.5.0.tar.gz
cd protobuf-2.5.0
./configure
make
make install
ldconfig
cd ~/
wget https://archive.apache.org/dist/hadoop/core/hadoop-2.4.1/hadoop-2.4.1-src.tar.gz
tar xzf hadoop-2.4.1-src.tar.gz
cd ~/hadoop-2.4.1-src
mvn package -Pdist -Pdoc -Psrc -Dtar -DskipTests
cd hadoop-dist/
mvn package -Pdist,native,docs -DskipTests -Dtar
mv target/hadoop-2.4.1 /usr/local/hadoop
cd /usr/local/hadoop/
cp -rvf /root/cluster-computing/configs/hadoop/* /usr/local/hadoop/etc/hadoop/
chown -R hduser:hadoop /usr/local/hadoop/
```

- Starting hdfs for the first time (RUN ON MASTER ONLY)
<br>After running these steps go http://YOUR_SERVER_IP:50070/dfshealth.html#tab-datanode to ensure node is running
```bash
cd /usr/local/hadoop/
sudo -i -u hduser mkdir -p /usr/local/hadoop/hadoop_data/hdfs/namenode
sudo -i -u hduser hdfs namenode -format
sudo -i -u hduser ./sbin/start-dfs.sh
```

- Adding Nodes to Cluster(RUN ON MASTER ONLY)
<br> The script add-node-hadoop.sh modifies /usr/local/hadoop/etc/hadoop/slaves and adds the new node
```bash
sudo -i -u hduser bash /root/cluster-computing/scripts/add-node-hadoop.sh NEW_NODES_IP
sudo -i -u hduser hdfs dfsadmin -refreshNodes
```

- Hive and Derby (RUN ON MASTER ONLY)
```bash
wget https://archive.apache.org/dist/hive/hive-0.14.0/apache-hive-0.14.0-bin.tar.gz
tar zxf apache-hive-0.14.0-bin.tar.gz
mv apache-hive-0.14.0-bin /usr/local/hive
cp -rvf /root/cluster-computing/configs/hive/* /usr/local/hive/conf/
wget http://archive.apache.org/dist/db/derby/db-derby-10.4.2.0/db-derby-10.4.2.0-bin.tar.gz
tar zxf db-derby-10.4.2.0-bin.tar.gz
mv db-derby-10.4.2.0-bin /usr/local/derby
mkdir /usr/local/derby/data
```


- Creating Distributed File System (RUN ON MASTER ONLY)
```bash
chown -R hduser:hadoop /usr/local/hive/ /usr/local/derby/
sudo -i -u hduser hadoop fs -mkdir -p /user/spark/applicationHistory
sudo -i -u hduser hadoop fs -chmod 1777 /user/spark/applicationHistory
sudo -i -u hduser hadoop fs -mkdir -p /tmp
sudo -i -u hduser hadoop fs -chmod g+w /tmp
sudo -i -u hduser hadoop fs -mkdir -p /usr/hive/warehouse
sudo -i -u hduser hadoop fs -chmod g+w /usr/hive/warehouse
sudo -i -u hduser /usr/local/hive/bin/hive #test to make sure hive works
```

### Spark installation from source
```bash
cd /usr/local
git clone git://github.com/apache/spark.git -b branch-1.6
cd spark
cp -rvf /root/cluster-computing/configs/spark/* /usr/local/spark/conf/
./build/mvn -Pyarn -Phadoop-2.4 -Dscala-2.10 -Phive -DskipTests clean package
chown -R hduser:hadoop /usr/local/spark
```
- RSpark Setup
```bash
Rscript -e 'install.packages("devtools", repos="https://cran.rstudio.com")'
Rscript -e 'install.packages("roxygen2", repos="https://cran.rstudio.com")'
Rscript -e 'install.packages("testthat", repos="https://cran.rstudio.com")'
Rscript -e 'install.packages("knitr", repos="https://cran.rstudio.com")'
Rscript -e 'install.packages("rmarkdown", repos="https://cran.rstudio.com")'
bash /usr/local/spark/R/install-dev.sh
bash /usr/local/spark/R/run-tests.sh #if fails with clock related error ignore it
```

- Mahout Setup (RUN ON MASTER ONLY)
```bash
cd /usr/local
git clone git@github.com:apache/mahout.git
cd mahout
mvn -DskipTests clean install
chown -R hduser:hadoop /usr/local/mahout
```






