#! /bin/sh

test -f ./settings.sh && . ./settings.sh
TESTBENCH="${TESTBENCH_DIR}/sample-queries-tpcds"

for f in `ls -1 ${TESTBENCH}/*.sql | sort -n`; do
	t=`basename "${f}"`
	echo "# ${t}"
	echo "hive --database tpcds_bin_partitioned_orc_${SCALE_TPCDS} -i '${TESTBENCH}/testbench.settings' -f '${TESTBENCH}/${t}' 2>&1"
done
