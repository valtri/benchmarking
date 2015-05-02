#! /bin/sh

JAR='/usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar'
N=10

echo '# teragen'
echo "hadoop jar '${JAR}' teragen 200000 gendata 2>&1"
for i in `seq 1 ${N}`; do
	echo '# terasort'
	echo "hadoop jar '${JAR}' terasort gendata sorted-${i} 2>&1"
	echo '# teravalidate'
	echo "hadoop jar '${JAR}' teravalidate sorted-${i} reportdata-${i} 2>&1"
done
