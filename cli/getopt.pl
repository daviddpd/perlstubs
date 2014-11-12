#!/usr/bin/perl

use strict;
use warnings;

# Getopt::Long::Descriptive - 
#    Getopt::Long, but simpler and more powerful
# http://search.cpan.org/~rjbs/Getopt-Long-Descriptive-0.097/lib/Getopt/Long/Descriptive.pm

#
# I find that the Descriptive is cleaner to read, and 
# also self documenting on usage()
#

use Getopt::Long::Descriptive;
use Data::Dumper::Simple;

# Type declarations are '=x' or ':x', 
# where = means a value is required and : means it is optional.
# x may be 's' to indicate a string is required, 
# 'i' for an integer, or 'f' for a number with a fractional part. 
# The type spec may end in @ to indicate that the option may 
# appear multiple times.


my ($opt, $usage) = describe_options(
	'%c %o',
	[ 'help|h', "help, print usage", ],
	[ 'str|s=s', "string", {required => 1},   ], 
	[ 'flag', "boolean flag",   ], 
	[ 'int|i=i', "interger option", { default => 1 }  ],
	[ 'float|f=f', "interger option", { default => 0.1 }  ],
	
# FIXME: I haven't been able to figure out the syntax for multiple times.
#	[ 'debug|d:@', "file to copy",  ],
);


print($usage->text), exit if $opt->help;

print Dumper ( $opt );
