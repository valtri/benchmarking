#! /bin/sh -e

test -f ./settings.sh && . ./settings.sh

if [ -z "${NC_HOSTS}" ]; then
	exit 0
fi

for h in ${NC_HOSTS}; do
	h1=`echo ${h} | cut -d: -f1`
	h2=`echo ${h} | cut -d: -f2`
	ssh ${NC_USER}@${h1}${NC_DOMAIN} 'rm -fv ${HOME}/test.dat'
done
