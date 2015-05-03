# repeat of basic benchmarks
N_PI=10
N_RANDOMWRITER=2
N_TERASORT=10

# dfsio
DFSIO_NUMFILES=10
DFSIO_SIZE=2000

# Hortonworks Hive Benchmarks
TESTBENCH_DIR="/scratch/`id -nu`/hive-testbench"
SCALE_TPCDS=500
SCALE_TPCH=100

# < 2.6.0
#JAR_DFSIO='/usr/lib/hadoop-0.20-mapreduce/hadoop-test.jar'
# >= 2.6.0
JAR_DFSIO='/usr/lib/hadoop-mapreduce/hadoop-mapreduce-client-jobclient-tests.jar'
JAR_MR='/usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar'
