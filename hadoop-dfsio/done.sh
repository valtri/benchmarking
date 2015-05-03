#! /bin/sh -e

test -f ./settings.sh && . ./settings.sh

hadoop jar "${JAR_DFSIO}" TestDFSIO -D test.build.data=./dfsio -clean 2>&1
