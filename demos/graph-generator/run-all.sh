#!/bin/bash
echo 3 $1 $2 2 20 NodeData.txt 0 | ./graphgen 
perl -lape 's/\s+//sg' NodeData.txt > temp.txt
rm NodeData.txt
mv temp.txt NodeData.txt
cat NodeData.txt
