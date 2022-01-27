#!/usr/local/bin/perl

use strict;
use warnings;

use Getopt::Long::Descriptive;
use Data::Dumper::Simple;
use JSON; 
use Parallel::ForkManager;


use IO::Socket::INET;

my ($opt, $usage) = describe_options(
	'%c %o',
	[ 'help|h', "help, print usage", ],
	[ 'verbose|v', "verbose"],
	[ 'ip=s', "list on", { default => '0.0.0.0' }, ],	
	[ 'port=i', "port", { default => 7272 } ],		
	[ 'workers|w=i', "number of workers/childer", { default => 5 }  ],
	
);
print($usage->text), exit if $opt->help;


$| = 1;
my $socket = new IO::Socket::INET (
    LocalHost => $opt->{'ip'},
    LocalPort => $opt->{'port'},
    Proto => 'tcp',
    Listen => $opt->{'workers'},
    Reuse => 1
);
if ( $socket ) {
	print "server waiting for client connection on port " . $opt->{'port'} ."\n";
} else {
	die "cannot create socket $!\n";
}

my $pm = new Parallel::ForkManager($opt->{'workers'});

while(1)
{
    my $client_socket = $socket->accept();    
	my $child_pid = $pm->start;
	if ( $child_pid == 0 ) {
		my $client_address = $client_socket->peerhost();
		my $client_port = $client_socket->peerport();
		print "connection from $client_address:$client_port\n";
		my $data = "";
		$client_socket->recv($data, 1024);
		print "received data: $data\n"; 
		$data = "ok";
		$client_socket->send($data);
		$pm->finish;
	}  
}

$pm->wait_all_children;
