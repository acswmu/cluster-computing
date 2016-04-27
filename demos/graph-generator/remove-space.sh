#!/bin/bash
perl -lape 's/\s+//sg' $1 > temp.txt
rm $1
mv temp.txt $1
