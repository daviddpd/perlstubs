#!perl 

use strict;
use warnings;
use Getopt::Long::Descriptive;
use Data::Dumper::Simple;
use Text::CSV qw( csv );

my ($opt, $usage) = describe_options(
	'%c %o',
	[ 'help|h', "help, print usage", ],
	[ 'file|f=s', "string", {required => 1},   ]
);
	

my $aoh = csv(in => ,	$opt->{"file"}, headers => "auto");   # as array of hash


print Dumper ( $aoh );