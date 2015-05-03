#! /bin/sh

test -f ./settings.sh && . ./settings.sh

echo '# teragen'
echo "hadoop jar '${JAR_MR}' teragen 200000 gendata 2>&1"
for i in `seq 1 ${N_TERASORT}`; do
	echo '# terasort'
	echo "hadoop jar '${JAR_MR}' terasort gendata sorted-${i} 2>&1"
	echo '# teravalidate'
	echo "hadoop jar '${JAR_MR}' teravalidate sorted-${i} reportdata-${i} 2>&1"
done
