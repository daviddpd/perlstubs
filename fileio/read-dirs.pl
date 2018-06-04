#!/usr/bin/perl

use strict;
use warnings;

# pretty much exactly from the perlfunc docs/man page

my $dir = $ARGV[0];
print $dir . "\n";

opendir(my $dh, $dir) || die "Can't open $dir: $!";
while (readdir $dh) {
    print "$dir/$_\n";
}
closedir $dh;