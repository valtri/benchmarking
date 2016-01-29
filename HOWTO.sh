#
# Generic benchmark launcher.
#

# repeating:
for i in `seq 1 5`; do rm -rf result${i}; done
for i in `seq 1 5`; do echo ${i}; ./run.pl -o result${i}; done

# single suite:
rm -rf results
./run.pl -s suite1

# analyze
PREFIX=A ./averager.pl resultA1/ resultA2/
PREFIX=B ./averager.pl resultB1/ resultB2/

cat resultA*/TestDFSIO_results.log | ./dfsio-averager.pl > A-dfsio.csv
cat resultB*/TestDFSIO_results.log | ./dfsio-averager.pl > B-dfsio.csv
