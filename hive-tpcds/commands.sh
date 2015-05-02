#! /bin/sh

TESTBENCH='/scratch/valtri/hive-testbench/sample-queries-tpcds'
SCALE=500

for f in `ls -1 ${TESTBENCH}/*.sql | sort -n`; do
	t=`basename "${f}"`
	echo "# ${t}"
	echo "hive --database tpcds_bin_partitioned_orc_${SCALE} -i '${TESTBENCH}/testbench.settings' -f '${TESTBENCH}/${t}' 2>&1"
done
