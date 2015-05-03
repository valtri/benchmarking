#! /bin/sh -e

test -f ./settings.sh && . ./settings.sh

s='gendata'
for i in `seq 1 ${N_TERASORT}`; do
	s="${s} sorted-${i} reportdata-${i}"
done

hdfs dfs -rm -r ${s} 2>&1 || :
