echo "Requires class and project folder"
spark-submit \
--class $1 \
--master spark://192.168.1.1:7077 \
/root/cluster-computing/demos/$2/src/target/scala-2.10/simple-project_2.10-1.0.jar
