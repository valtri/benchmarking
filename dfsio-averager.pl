#! /usr/bin/perl
use strict;
use warnings;

my ($op, $n, $bytes);
my ($throughput, $rate, $time);

my %dfsio;

while (<>) {
	chomp;

	if (/----- TestDFSIO ----- : (.*)/) {
		$op = $1;
	} elsif (/Number of files: (.*)/) {
		$n = $1;
	} elsif (/Total MBytes processed: (.*)/) {
		$bytes = $1;
	} elsif (/Throughput mb\/sec: (.*)/) {
		$throughput = $1;
	} elsif (/Average IO rate mb\/sec: (.*)/) {
		$rate = $1;
	} elsif (/Test exec time sec: (.*)/) {
		$time = $1;
	} elsif (/^$/) {
		if (not exists $dfsio{$op}{$n}{$bytes}) {
			$dfsio{$op}{$n}{$bytes}{'n'} = 0;
			$dfsio{$op}{$n}{$bytes}{'throughput'} = 0;
			$dfsio{$op}{$n}{$bytes}{'rate'} = 0;
			$dfsio{$op}{$n}{$bytes}{'time'} = 0;
		}
		$dfsio{$op}{$n}{$bytes}{'n'}++;
		$dfsio{$op}{$n}{$bytes}{'throughput'} += $throughput;
		$dfsio{$op}{$n}{$bytes}{'rate'} += $rate;
		$dfsio{$op}{$n}{$bytes}{'time'} += $time;

		$op = undef;
		$n = undef;
		$bytes = undef;
		$throughput = undef;
		$rate = undef;
		$time = undef;
	}
}


print "operation,nfiles,totalbytes,n,throughput,rate,time\n";
for $op (sort keys %dfsio) {
	for $n (sort keys %{$dfsio{$op}}) {
		for $bytes (keys %{$dfsio{$op}{$n}}) {
			my %item = %{$dfsio{$op}{$n}{$bytes}};
			$throughput = $item{'throughput'} / $item{'n'};
			$rate = $item{'rate'} / $item{'n'};
			$time = $item{'time'} / $item{'n'};
			print "$op,$n,$bytes,$item{n},$throughput,$rate,$time\n";
		}
	}
}
