#! /bin/sh

JAR='/usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar'
N=10

for i in `seq 1 ${N}`; do
	echo '# pi'
	echo "hadoop jar '${JAR}' pi 200 10000 2>&1"
done
