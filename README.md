# Generic Benchmark Launcher

This is a generic framework to launch benchmarks and measure the running time. All benchmarks are stored in subdirectories.

Commands:

* *run.pl*: main launcher script
* *averager.pl*: read all \*.csv files in all specified directories and produce summary \*.csv files with average values
* *dfsio-averager.pl*: read stdio with DFSIO logs and produce summary csv output with average values

# Benchmark subdirectories

As benchmark is considered each directory containing file *commands.sh*.

Benchmark directory content:

* *init.sh* (optional): launched first; When fails, it is considered fatal and it stops.
* *commands.sh*: script for producing **commands** to run
* *done.sh* (optional): cleanups

# Benchmarks used

## hadoop-dfsio

Hadoop DFSIO write and read.

## hadoop-pi

Hadoop PI example.

## hadoop-randomwriter

Hadoop Randomwriter example.

## hadoop-terasort

Hadoop Teragen + Terasort + Teravalidate examples.

## netcat

Benchmark using netcat utility. Access to ssh on all hosts is needed.

Send USR1 signal to *dd* on the target host to write current progress to the log:

    killall dd -USR1

### Parameters

####NC\_HOSTS
= host1:host2 host3:host4

Enables the netcat benchmark. Transfer data host1 -> host2 and host3 -> host4.

####NC\_DOMAIN

Suffix added to all the hosts.

####NC\_N

Number of repeat of each transfer.

####NC\_PORT

Port to listen.

####NC\_SIZE\MB

Amount of transfered data (MB).

####NC\_USER

User to use for login.
