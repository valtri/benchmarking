#! /bin/sh

test -f ./settings.sh && . ./settings.sh

for h in ${NC_HOSTS}; do
	h1=`echo ${h} | cut -d: -f1`
	h2=`echo ${h} | cut -d: -f2`

	for i in `seq 1 ${NC_N}`; do
		echo "# netcat-${h1}-${h2}"
		echo "ssh ${NC_USER}@${h2}${NC_DOMAIN} \"nc -v -l -p ${NC_PORT} | dd of=/dev/null bs=1024\" 2>&1 & sleep 1; ssh ${NC_USER}@${h1}${NC_DOMAIN} \"(for i in \\\`seq 1 ${NC_SIZE_MB}\\\`; do cat \\\${HOME}/test.dat; done) | nc -v -q 0 ${h2}${NC_DOMAIN} ${NC_PORT}\" 2>&1"
	done
done
