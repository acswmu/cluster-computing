echo "Requires project folder"
spark-submit \
--master spark://192.168.1.1:7077 \
$1
