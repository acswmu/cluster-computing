#!/bin/bash
scp /home/hduser/.ssh/id_rsa.pub hduser@$1:.ssh/id_rsa.pub.W
ssh hduser@$1 'cat ~/.ssh/id_rsa.pub.W >> ~/.ssh/authorized_keys'
scp hduser@$1:.ssh/id_rsa.pub /home/hduser/.ssh/id_rsa.pub.C 
cat /home/hduser/.ssh/id_rsa.pub.C >> /home/hduser/.ssh/authorized_keys
echo $1 >> /usr/local/hadoop/etc/hadoop/slaves
echo "rsync -avxPI \$1 hduser@$1:\$1 " >> /root/cluster-computing/scripts/sync-nodes.sh
bash /root/cluster-computing/scripts/sync-nodes.sh /usr/local/hadoop/etc/hadoop/
ssh hduser@$1 'bash /usr/local/hadoop/sbin/hadoop-daemon.sh start datanode' 
