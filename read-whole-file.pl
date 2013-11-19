#!/usr/bin/perl

# 
# Read in a whole file into buffer, using only built-in modules/feautres 
# present in most if not all perl 5.x + installations .
#

use strict;
use warnings;

my $filename = $ARGV[0];
my $buffer;

my ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,$atime,$mtime,$ctime,$blksize,$blocks) = stat($filename);
open FH, "<$filename";
read (FH,$buffer,$size);
close FH;
