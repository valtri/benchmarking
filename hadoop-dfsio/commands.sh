#! /bin/sh

JAR='/usr/lib/hadoop-0.20-mapreduce/hadoop-test.jar'

cat <<EOF
# dfsio-write
hadoop jar '${JAR}' TestDFSIO -D test.build.data=./dfsio -write -nrFiles 10 -fileSize 2000 2>&1
# dfsio-read
hadoop jar '${JAR}' TestDFSIO -D test.build.data=./dfsio -read -nrFiles 10 -fileSize 2000 2>&1
EOF
