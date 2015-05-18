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
		}
		push @{$dfsio{$op}{$n}{$bytes}{'throughput'}}, $throughput;
		push @{$dfsio{$op}{$n}{$bytes}{'rate'}}, $rate;
		push @{$dfsio{$op}{$n}{$bytes}{'time'}}, $time;
		$dfsio{$op}{$n}{$bytes}{'n'}++;

		$op = undef;
		$n = undef;
		$bytes = undef;
		$throughput = undef;
		$rate = undef;
		$time = undef;
	}
}


print "operation,nfiles,totalbytes,n,throughput,rate,time,throughput_dev,rate_dev,time_dev\n";
for $op (sort keys %dfsio) {
	for $n (sort keys %{$dfsio{$op}}) {
		for $bytes (keys %{$dfsio{$op}{$n}}) {
			my ($throughput_dev, $rate_dev, $time_dev) = (0, 0, 0);

			my %item = %{$dfsio{$op}{$n}{$bytes}};
			my $count = $item{'n'};
			if ($count > 0) {
				($throughput, $rate, $time) = (0, 0, 0);
				for my $i (0 .. $count - 1) {
					$throughput += $item{'throughput'}[$i];
					$rate += $item{'rate'}[$i];
					$time += $item{'time'}[$i];
				}
				$throughput /= $count;
				$rate /= $count;
				$time /= $count;
			} else {
				($throughput, $rate, $time) = ('', '', '');
			}
			if ($count > 1) {
				for my $i (0 .. $count - 1) {
					$throughput_dev += ($throughput - $item{'throughput'}[$i]) * ($throughput - $item{'throughput'}[$i]);
					$rate_dev += ($rate - $item{'rate'}[$i]) * ($rate - $item{'rate'}[$i]);
					$time_dev += ($time - $item{'time'}[$i]) * ($time - $item{'time'}[$i]);
				}
				$throughput_dev = sqrt($throughput_dev / ($count - 1));
				$rate_dev = sqrt($rate_dev / ($count - 1));
				$time_dev = sqrt($time_dev / ($count - 1));
			} else {
				($throughput_dev, $rate_dev, $time_dev) = ('', '', '');
			}

			print "$op,$n,$bytes,$item{n},$throughput,$rate,$time,$throughput_dev,$rate_dev,$time_dev\n";
		}
	}
}
