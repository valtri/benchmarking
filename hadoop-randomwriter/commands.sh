#! /bin/sh

test -f ./settings.sh && . ./settings.sh

for i in `seq 1 ${RANDOMWRITER_N}`; do
	echo "# randomwriter"
	echo "hadoop jar '${JAR_MR}' randomwriter randomwriter-${i} 2>&1"
done
