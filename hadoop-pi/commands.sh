#! /bin/sh

test -f ./settings.sh && . ./settings.sh

for i in `seq 1 ${N_PI}`; do
	echo '# pi'
	echo "hadoop jar '${JAR_MR}' pi 200 10000 2>&1"
done
