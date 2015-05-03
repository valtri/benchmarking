#! /bin/sh

test -f ./settings.sh && . ./settings.sh
TESTBENCH="${TESTBENCH_DIR}/sample-queries-tpch"

for f in `ls -1 ${TESTBENCH}/*.sql | sort -n`; do
	t=`basename "${f}"`
	echo "# ${t}"
	echo "hive --database tpch_bin_flat_orc_${SCALE_TPCH} -i '${TESTBENCH}/testbench.settings' -f '${TESTBENCH}/${t}' 2>&1"
done
