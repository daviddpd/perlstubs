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


# recursive read and print all files

sub rdir() {
    my $dir = shift;
    opendir(my $dh, $dir) || die "Can't open $dir: $!";
    while (readdir $dh) {
        print "$dir/$_\n";
        if ( -d "$dir/$_" ) {
            next if ($_ =~/\.+$/);
            rdir ("$dir/$_");        
        }
    }
    closedir $dh;
}