#! /usr/bin/perl
use warnings;
use strict;
use File::Copy "move";
use Getopt::Std;
use Time::HiRes qw(gettimeofday);

my @suites;
my %opts;
my $output = './results/';

getopts('hno:s:', \%opts);

if ($opts{h}) {
	print "Usage: $0 [-n] [-o OUTPUT_DIR] [-s SUITE1,SUITE2,...]\n";
	exit 0
}

if ($opts{o}) {
	$output = $opts{o};
	if (!($output =~ /\/$/)) {
		$output .= '/';
	}
}
`mkdir -p '${output}'`;

if ($opts{s}) {
	@suites = split(/,/, $opts{s});
} else {
	@suites = glob('*/commands.sh');

	for my $i (0..$#suites) {
		$suites[$i] =~ s,/commands\.sh$,,;
	}
}

my $count;
my $command;
my @commands;
my $suiteElapsed;
`test -f ${output}benchmark.csv || echo 'suite,time' > ${output}benchmark.csv`;
for my $isuite (0..$#suites) {
	my $suite = $suites[$isuite];
	print "$suite:\n";

	$count = 0;
	@commands = {};

	open FH, "$suite/commands.sh|" or die;
	$count++;
	$command->{name} = "$count";
	while(<FH>) {
		chomp;
		if (/^#\s*(.*)/) {
			$command->{name} = $1;
		} else {
			$command->{cmd} = $_;
			push @commands, $command;

			$count++;
			$command = undef;
			$command->{name} = "$count";
		}
	}
	close FH;

	if (-x "$suite/init.sh") {
		`(date --iso-8601=ns; ($suite/init.sh || echo FAILED return code \"\$?\"); date --iso-8601=ns) | tee $output$suite-0-init.log`;
		`grep -vq FAILED $output$suite-0-init.log`;
		if ($? != 0) {
			die "Failed to initialize suite $suite!";
		}
	}

	$suiteElapsed = 0;
	open FH, '>', "${output}${suite}.csv" or die;
	print FH "name,status,time\n";
	for my $i (1..$#commands) {
		my ($cmd, $log, $startSec, $startUsec, $endSec, $endUsec, $elapsed, $status);

		$command = $commands[$i];
		$log = "$output$suite-$i-$command->{name}.log";
		$cmd = "(date --iso-8601=ns; ($command->{cmd} || echo FAILED return code \"\$?\"); date --iso-8601=ns) | tee $log";

		print "  $command->{name}:";
		#print "  $cmd";
		($startSec, $startUsec) = gettimeofday();
		$status = 'SUCCESS';
		`$cmd`;
		if ($? != 0) {
                  $status = 'FATAL';
                }
		($endSec, $endUsec) = gettimeofday();

		open LH, '<', $log or die;
		while (<LH>) {
			chomp;
			if ($_ =~ /FAILED/) {
				$status = 'FAILED';
			}
		}
		close LH;

		$elapsed = ($endSec - $startSec) + ($endUsec - $startUsec) / 1000000.0;
		print "  => $elapsed s, status $status\n";

		print FH "$command->{name},$status,$elapsed\n";
		$suiteElapsed += $elapsed;
	}
	close FH;

	`echo ${suite},${suiteElapsed} >> ${output}benchmark.csv`;
}

if (!$opts{n}) {
	for my $isuite (0..$#suites) {
		my $suite = $suites[$isuite];

		if (-x "$suite/done.sh") {
			`(date --iso-8601=ns; ($suite/done.sh || echo FAILED return code \"\$?\"); date --iso-8601=ns) | tee $output$suite-0-done.log`;
			`grep -vq FAILED $output$suite-0-done.log`;
			if ($? != 0) {
				print "Failed to clean up suite $suite!\n";
			}
		}
	}

	if (-f 'TestDFSIO_results.log') {
		if (-f "${output}TestDFSIO_results.log") {
			`cat TestDFSIO_results.log >> ${output}TestDFSIO_results.log`;
			unlink 'TestDFSIO_results.log';
		} else {
			move('TestDFSIO_results.log', $output);
		}
	}
}
