#! /bin/sh -e

N=2

s=''
for i in `seq 1 ${N}`; do
	s="${s} randomwriter-${i}"
done

hdfs dfs -rm -r ${s} 2>&1 || :
