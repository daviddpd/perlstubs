#!/usr/bin/perl

use strict;
use warnings;

use Getopt::Long::Descriptive;
use Date::Parse;


my ($opt, $usage) = describe_options(
	'%c %o',
	[ 'd=s', "date string to parse", ], 
);


my $unixtime = str2time($opt->{'d'}) || die ("can't parse date");

#my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = gmtime($unixtime);

#my $date = sprintf ("%04d-%02d-%02d %02d:%02d:%02d GMT", 1900+$year, $mon+1, $mday, $hour,$min,$sec);


#print "got: " . $opt->{'d'} . "\n";
#print "unixtime: $unixtime\n";
#print "date string: $date\n";
print "$unixtime\n";
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($unixtime);

my $date = sprintf ("%04d-%02d-%02d %02d:%02d:%02d - %s", 1900+$year, $mon+1, $mday, $hour,$min,$sec,$wday);

print "date string: $date\n";


