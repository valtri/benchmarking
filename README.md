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

* Hadoop DFSIO write and read
* Hadoop PI
* Hadoop Randomwriter
* Hadoop Teragen + Terasort + Teravalidate
* Hive TPCDS + TPCH
