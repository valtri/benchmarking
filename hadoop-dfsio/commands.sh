#! /bin/sh

test -f ./settings.sh && . ./settings.sh

cat <<EOF
# dfsio-write
hadoop jar '${JAR_DFSIO}' TestDFSIO -D test.build.data=./dfsio -write -nrFiles ${DFSIO_NUMFILES} -fileSize ${DFSIO_SIZE} 2>&1
# dfsio-read
hadoop jar '${JAR_DFSIO}' TestDFSIO -D test.build.data=./dfsio -read -nrFiles ${DFSIO_NUMFILES} -fileSize ${DFSIO_SIZE} 2>&1
EOF
