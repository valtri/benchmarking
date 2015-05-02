#! /bin/sh

JAR='/usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar'
N=2

for i in `seq 1 ${N}`; do
	echo "# randomwriter"
	echo "hadoop jar '${JAR}' randomwriter randomwriter-${i} 2>&1"
done
