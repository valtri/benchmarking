#! /bin/sh

test -f ./settings.sh && . ./settings.sh

echo '# teragen'
echo "hadoop jar '${JAR_MR}' teragen ${TERASORT_SIZE} gendata 2>&1"
for i in `seq 1 ${TERASORT_N}`; do
	echo '# terasort'
	echo "hadoop jar '${JAR_MR}' terasort gendata sorted-${i} 2>&1"
	echo '# teravalidate'
	echo "hadoop jar '${JAR_MR}' teravalidate sorted-${i} reportdata-${i} 2>&1"
done
