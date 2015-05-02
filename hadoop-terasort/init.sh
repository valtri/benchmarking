#! /bin/sh -e

N=10

s='gendata'
for i in `seq 1 ${N}`; do
	s="${s} sorted-${i} reportdata-${i}"
done

hdfs dfs -rm -r ${s} 2>&1 || :
