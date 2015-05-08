#! /bin/sh

test -f ./settings.sh && . ./settings.sh

for i in `seq 1 ${PI_N}`; do
	echo '# pi'
	echo "hadoop jar '${JAR_MR}' pi ${PI_TASKS} ${PI_COUNT} 2>&1"
done
