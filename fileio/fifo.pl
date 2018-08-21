#!/usr/local/bin/perl

use strict;
use warnings;

use Getopt::Long::Descriptive;
use Data::Dumper::Simple;
use POSIX;

my ($opt, $usage) = describe_options(
	'%c %o',
	[ 'help|h', "help, print usage", ],
	[ 'verbose|v', "verbose"],
	[ 'fifo|f=s', "Fifo/named pipe patch", { required => 1 } ],	
	[ 'read', "read from fifo", ],
	[ 'write', "write to fifo", ],
	
	
);

my $fifopath = $opt->{'fifo'};
print($usage->text), exit if $opt->help;

my $buf = '';
my $i=0;
while (1) {
   if ($opt->read) 
   {
        if ( ! -p $fifopath ) {
            POSIX::mkfifo($fifopath, 0700) || die "can't mkfifo $fifopath: $!";
        }
        open (FIFO, "< $fifopath")  || die "can't open $fifopath: $!";
        while (1)
        {
            my $l = sysread(FIFO,$buf,1024);
            if ( $l > 0 ) {
                chomp $buf;
                printf ( "READ: %s\n", $buf);
            }
        }
    } elsif ($opt->write) {
        if ( -p $fifopath ) {
            $i++;
            open (FIFO, "> $fifopath")  || die "can't open $fifopath: $!";
            my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
            my $date = sprintf ("%04d-%02d-%02d %02d:%02d:%02d", 1900+$year, $mon+1, $mday, $hour,$min,$sec);
            printf FIFO "[ %08d ] %s\n", $i, $date;
            sleep 1;                # to avoid dup signals
        } else {
            print ( "Waiting for FIFO $fifopath \n" );
            sleep 2;
        }
    }    
}