#! /usr/bin/perl
use warnings;
use strict;
use File::Basename;

my $prefix = 'avg-';
my $dir;
my (%csv_headers, %csv_values);
my ($NAME, $TIME);

if ($#ARGV < 0) {
	print "Usage: $0 DIR1 DIR2 ...\n";
	exit 0
}

if (defined $ENV{'PREFIX'}) {
	$prefix = $ENV{'PREFIX'};
}

while ($ARGV[0]) {
	$dir = $ARGV[0];
	while ($dir =~ /(.*)\/$/) {
		$dir = $1;
	}

	#print "DIR: ${dir}\n";
	for my $file (glob("${dir}/*.csv")) {
		my $filename = basename($file, '.csv');
		#print "FILE: $file\n";
		#print "NAME: $filename\n";

		$NAME = 0;
		if ($filename eq 'benchmark') {
			$TIME = 1;
		} else {
			$TIME = 2;
		}

		open FH, '<', "$file" or die;
		$_ = <FH>;
		chomp;
		$csv_headers{$filename} = $_;
		while ($_ = <FH>) {
			chomp;
			my @a = split /,/;
			if (not defined $csv_values{$filename}{$a[$NAME]}) {
				$csv_values{$filename}{$a[$NAME]} = [];
			}
#print STDERR "$filename,$a[$NAME],$a[$TIME]\n";

			push @{$csv_values{$filename}{$a[$NAME]}}, $a[$TIME];

			# summaries over all hosts for netcat benchmarks
			if ($filename eq 'netcat') {
				push @{$csv_values{$filename}{'netcat'}}, $a[$TIME];
			}
		}
		close FH;
	}

	shift;
}


open FH_ALL, '>', "${prefix}all.csv" or die;
print FH_ALL "name,count,elapsed,deviation\n";
for my $filename (keys %csv_values) {
	my %data = %{$csv_values{$filename}};

	open FH, '>', "${prefix}${filename}.csv" or die;
	print "$filename\n";
	print FH "name,count,elapsed,deviation\n";
#print STDERR "file: $filename\n";
	for my $testname (keys %data) {
		my ($average, $count, $deviation);

		$average = 0;
		$count = $#{$data{$testname}} + 1;
		$deviation = 0;
#print STDERR "file: $filename, test: $testname, count: $count\n";
		for my $i (0..$count - 1) {
			$average += $data{$testname}[$i];
		}
		if ($count) {
			$average /= $count;
		} else {
			$average = '';
		}
		if ($count > 1) {
			for my $i (0..$count - 1) {
				$deviation += ($average - $data{$testname}[$i]) * ($average - $data{$testname}[$i]);
			}
			$deviation = sqrt($deviation / ($count - 1));
		} else {
			$deviation = '';
		}
		print FH "$testname,$count,$average,$deviation\n";
		if (not $filename =~ /^benchmark$/) {
			print FH_ALL "$testname,$count,$average,$deviation\n";
		}
	}
	close FH;
}
close FH_ALL;
