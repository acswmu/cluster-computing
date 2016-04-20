echo "Requires class and project folder"
spark-submit \
--class $1 \
--master spark://192.168.1.1:7077 \
/root/cluster-computing/demos/$2/target/scala-2.10/*.jar
