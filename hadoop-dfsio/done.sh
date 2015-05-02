#! /bin/sh

JAR='/usr/lib/hadoop-0.20-mapreduce/hadoop-test.jar'

hadoop jar "${JAR}" TestDFSIO -D test.build.data=./dfsio -clean 2>&1
