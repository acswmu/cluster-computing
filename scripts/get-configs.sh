rm -rf /root/cluster-computing/configs/*
cp -Rv /usr/local/hadoop/etc/hadoop/slaves /root/cluster-computing/configs/
cp -Rv /usr/local/hadoop/etc/hadoop/masters /root/cluster-computing/configs/
cp -Rv /usr/local/hadoop/etc/hadoop/hdfs-site.xml /root/cluster-computing/configs/
cp -Rv /usr/local/hadoop/etc/hadoop/yarn-site.xml /root/cluster-computing/configs/
cp -Rv /usr/local/hadoop/etc/hadoop/mapred-site.xml /root/cluster-computing/configs/
cp -Rv /usr/local/hadoop/etc/hadoop/core-site.xml /root/cluster-computing/configs/
