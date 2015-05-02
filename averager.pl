#! /usr/bin/perl
use warnings;
use strict;
use File::Basename;

my $prefix = 'avg-';
my $dir;
my (%csv_headers, %csv_data, %csv_counts);
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
			if (defined $csv_data{$filename}{$a[$NAME]}) {
				$csv_data{$filename}{$a[$NAME]} += $a[$TIME];
				$csv_counts{$filename}{$a[$NAME]}++;
			} else {
				$csv_data{$filename}{$a[$NAME]} = $a[$TIME];
				$csv_counts{$filename}{$a[$NAME]} = 1;
			}
		}
		close FH;
	}

	shift;
}


for my $filename (keys %csv_data) {
	my %data = %{$csv_data{$filename}};
	my %counts = %{$csv_counts{$filename}};

	open FH, '>', "${prefix}${filename}.csv" or die;
	print "$filename\n";
	print FH "name,count,elapsed\n";
	for my $testname (keys %data) {
		my $value = $data{$testname} / $counts{$testname};
		print FH "$testname,$counts{$testname},$value\n";
	}
	close FH;
}
