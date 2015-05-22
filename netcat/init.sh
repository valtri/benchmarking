#! /bin/sh -e

test -f ./settings.sh && . ./settings.sh

if [ -z "${NC_HOSTS}" ]; then
	exit 0
fi

# try to connect to all the hosts
for h in ${NC_HOSTS}; do
	h1=`echo ${h} | cut -d: -f1`
	h2=`echo ${h} | cut -d: -f2`

	ssh ${NC_USER}@${h1}${NC_DOMAIN} 'uname -n'
	ssh ${NC_USER}@${h2}${NC_DOMAIN} 'uname -n'
done

# cleanups
`dirname $0`/done.sh

# random file
for h in ${NC_HOSTS}; do
	h1=`echo ${h} | cut -d: -f1`

	ssh ${NC_USER}@${h1}${NC_DOMAIN} "dd if=/dev/urandom of=\${HOME}/test.dat bs=1024k count=1 2>&1"&
done
wait
