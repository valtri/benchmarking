#! /bin/sh -e

test -f ./settings.sh && . ./settings.sh

s=''
for i in `seq 1 ${N_RANDOMWRITER}`; do
	s="${s} randomwriter-${i}"
done

hdfs dfs -rm -r ${s} 2>&1 || :
