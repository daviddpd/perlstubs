#!/usr/bin/perl

use strict;
use warnings;

# pretty much exactly from the perlfunc docs/man page

my $dir = $ARGV[0];
print $dir . "\n";

my $dir = $opt->{"dir"};
opendir(my $dh, $dir) || die "Can't open $dir: $!";
rdir ("$dir");
closedir $dh;

# recursive read and print all files

sub rdir {
    my $dir = shift;
    opendir(my $dh, $dir) || die "Can't open $dir: $!";
    while (readdir $dh) {
    	my $d = $_;
		next if ($d =~/\.+$/);
		if ( -d "$dir/$d"  ) {
			print "recurse : $dir/ ( $d ) \n";
			rdir ("$dir/$d");
		}
    }
    closedir $dh;
}
