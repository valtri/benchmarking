PI_N=10
PI_TASKS=300
PI_COUNT=40000

RANDOMWRITER_N=5

DFSIO_NUMFILES=10
DFSIO_SIZE=10000

TERASORT_N=5
TERASORT_SIZE=100000000

# < 2.6.0
#JAR_DFSIO='/usr/lib/hadoop-0.20-mapreduce/hadoop-test.jar'
# >= 2.6.0
JAR_DFSIO='/usr/lib/hadoop-mapreduce/hadoop-mapreduce-client-jobclient-tests.jar'
JAR_MR='/usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar'

#
# netcat test
#
# enabling by NC_HOSTS
#

#NC_HOSTS="host1:host2 host1:host3 host2:host1 host2:host3 host3:host2"
#NC_DOMAIN='.example.com'
NC_N=5
NC_PORT=10000
NC_SIZE_MB=40960
NC_USER='root'
