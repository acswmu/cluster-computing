# Note: please place the following line in /root/.bashrc
# source /root/cluster-computing/.bash_aliases
alias edit-alias='vim /root/cluster-computing/.bash_aliases'
alias config-dhcp='vim /etc/dhcp/dhcpd.conf'
alias config-dns='vim /etc/bind/db.acs'
alias config-ports='vim /etc/opt/forwards'
alias config-nat='vim /usr/local/bin/iptables-config'
alias restart-all='iptables-config ; service bind9 restart ; service isc-dhcp-server restart'
alias refresh-aliases='source /root/cluster-computing/.bash_aliases ; chmod +x /root/cluster-computing/scripts/*'

export PATH=$PATH:/root/cluster-computing/scripts

#SPARK VARIABLES START
export PATH=$PATH:/usr/local/spark/bin
export PATH=$PATH:/usr/local/spark/sbin
export PATH=/usr/local/maven/bin:$PATH
export R_HOME=/usr/lib/R
#SPARK VARIABLES END

#HIVE VARIABLES START
export HIVE_HOME=/usr/local/hive
export PATH=$PATH:$HIVE_HOME/bin
export CLASSPATH=$CLASSPATH:/usr/local/Hadoop/lib/*:.
export CLASSPATH=$CLASSPATH:/usr/local/hive/lib/*:.
#HIVE VARIABLES END

#DERBY VARIABLES START
export DERBY_HOME=/usr/local/derby
export PATH=$PATH:$DERBY_HOME/bin
export CLASSPATH=$CLASSPATH:$DERBY_HOME/lib/derby.jar:$DERBY_HOME/lib/derbytools.jar
#DERBY VARIABLES END

#HADOOP VARIABLES START
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
export HADOOP_INSTALL=/usr/local/hadoop
export PATH=$PATH:$HADOOP_INSTALL/bin
export PATH=$PATH:$HADOOP_INSTALL/sbin
export HADOOP_MAPRED_HOME=$HADOOP_INSTALL
export HADOOP_COMMON_HOME=$HADOOP_INSTALL
export HADOOP_HDFS_HOME=$HADOOP_INSTALL
export YARN_HOME=$HADOOP_INSTALL
export LD_LIBRARY_PATH=$HADOOP_INSTALL/lib/native
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_INSTALL/lib/native
export HADOOP_OPTS="-Djava.library.path=$HADOOP_INSTALL/lib"
#HADOOP VARIABLES END


function lazygit() {
    git add -A
    git commit -a -m "$1"
    git push
}

function supergit() {
    git add -A
    git commit -a -m "$1"
    git push
    ansible no-master -a "bash cluster-computing/scripts/git-pull.sh"
}
