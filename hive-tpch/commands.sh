#! /bin/sh

TESTBENCH='/scratch/valtri/hive-testbench/sample-queries-tpch'
SCALE=100

for f in `ls -1 ${TESTBENCH}/*.sql | sort -n`; do
	t=`basename "${f}"`
	echo "# ${t}"
	echo "hive --database tpch_bin_flat_orc_${SCALE} -i '${TESTBENCH}/testbench.settings' -f '${TESTBENCH}/${t}' 2>&1"
done
