#!/usr/bin/perl

# 
# Read in a whole file into buffer, using only built-in modules/feautres 
# present in most if not all perl 5.x + installations .
#

use strict;
use warnings;
use Image::ExifTool ':Public';
use Data::Dumper::Simple;

my $filename = $ARGV[0];
my $buffer;

my ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,$atime,$mtime,$ctime,$blksize,$blocks) = stat($filename);
open FH, "<$filename";
read (FH,$buffer,$size);
close FH;

my %h;
my %f;
my $mp=0;
my $total=0;

foreach my $file (split (/\n/, $buffer) ) {
#my $file = shift or die "Please specify filename";
	my $info = ImageInfo($file);
#	print Dumper ($info);
	my $x = $info->{'ImageSize'};
	if ( defined ($h{$x}) ) 
	{
		$h{$x}++;
	} else {
		$h{$x} = 1;		
	}
	$total++;
	my ($w,$h1) = split (/x/, $x );
	$mp +=  $w*$h1;

	$x = $info->{'FocalLength'};

	$x =~ s/ mm//g;
	
	if ( defined ($f{$x}) ) 
	{
		$f{$x}++;
	} else {
		$f{$x} = 1;
	}
	
	
	
}


foreach my $k (keys %h) 
{

	my ($w,$h1) = split (/x/, $k );
	print "$w,$h1,$h{$k}\n";

}

print "\n\n ========================================= \n\n";
foreach my $k (sort keys %f) 
{

	print "$k,$f{$k}\n";

}


print "MegaPixel Average: " . $mp/$total . "\n";