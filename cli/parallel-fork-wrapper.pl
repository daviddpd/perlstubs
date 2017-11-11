#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper::Simple;
use Getopt::Long::Descriptive;
use Parallel::ForkManager;

$|++;

my ($opt, $usage) = describe_options(
	'%c %o',
	[ 'verbose|v', "enable verbose output from script",   ],
	
	[ 'workers|w=i', "number of workers/childer", { default => 1 }  ],
	[ 'loops=i', "times to fork childer, deafaul = number of workers", ],
	[ 'cmd|c=s', "number of workers/childer", { default => 1 }  ],
	
);

my @errors;
my $pm = new Parallel::ForkManager($opt->{'workers'});
my $loops = 0;
if ( ! defined ( $opt->loops ) ) {
    $loops = $opt->workers;
} else {
    $loops = $opt->loops;
}

for ( my $i=0; $i<$loops; $i++) {
	my $child_pid = $pm->start;
	if ( $child_pid == 0 ) {
	    system ($opt->cmd);
		$pm->finish;	
	}
}

$pm->wait_all_children;

