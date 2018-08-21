#!/usr/local/bin/perl

use strict;
use warnings;

use Getopt::Long::Descriptive;
use Data::Dumper::Simple;
use JSON; 

use IO::Socket::INET;

my ($opt, $usage) = describe_options(
	'%c %o',
	[ 'help|h', "help, print usage", ],
	[ 'verbose|v', "verbose"],
	[ 'ip=s', "connect to", { default => '127.0.0.1' } ],
	[ 'port=i', "port", { default => 7272 } ],		
	
);

print($usage->text), exit if $opt->help;
$| = 1; 
sleep 1;
my $socket = new IO::Socket::INET (
    PeerHost =>  $opt->{'ip'},
    PeerPort => $opt->{'port'},
    Proto => 'tcp',
);

if ( $socket ) {
	print "connected to the server\n";
	my $req = 'hello world';
	my $size = $socket->send($req);
	print "sent data of length $size\n";
	shutdown($socket, 1);
	my $response = "";
	$socket->recv($response, 1024);
	print "received response: $response\n";
	$socket->close();
} else {
	die "cannot connect to the server $!\n";
}
