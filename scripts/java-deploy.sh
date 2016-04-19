echo "Requires class and project folder"
spark-submit \
--class $1 \
--master spark://192.168.1.1:7077 \
/root/cluster-computing/demos/$2/target/simple-project-1.0.jar

