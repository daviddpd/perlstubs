#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper::Simple;
use Getopt::Long::Descriptive;
use Parallel::ForkManager;
use File::Basename;
use Net::OpenSSH;

my $agent;
my %opts;
my %ssh_passwds;

$|++;

my $_user = $ENV{'USER'};

my ($opt, $usage) = describe_options(
	'%c %o',
	[ 'hostfile=s', 'file of hosts', {required => 1} ],
	[ 'cmd=s', "file to copy", {required => 1}  ],
	[ 'ssh|s', "do the ssh (default is not to)",   ], 
	[ 'sshdebug|d', "enable ssh debugging",   ],
	[ 'verbose|v', "enable verbose output from script",   ],
	[ 'workers|w=i', "number of workers/childer", { default => 1 }  ],
	[ 'copy=s', "file to copy",  ],
	[ 'destdir=s', "file to copy", { default => '/tmp' } ],
	[ 'user|u=s', "user name to use, default enviromental USER var", { default => $_user } ],
		
);


if ( $opt->ssh ) {
	$agent = $ENV{'SSH_AUTH_SOCK'} or die ("ssh-agent is not running, please run and try again");
	if ( $opt->sshdebug ) {
		$Net::OpenSSH::debug = -1;
	}
	%opts = ( 
			'user' => $opt->{'user'},
#			'password' => "", 
#			'proxy_command' => "env SSH_AUTH_SOCK=$agent ssh  -q -W %h:%p bastion.local",
			'timeout' => 1200,  
			'kill_ssh_on_timeout' => 0,
#			'master_opts' => ['-o' => "PreferredAuthentications keyboard-interactive,password"],
			
	);
	
}


if ( ! -f $opt->{'hostfile'} ) {
	die ( "Can't find hostfile $opt->{'hostfile'}");
}

my @hosts;
open FH, "<$opt->{'hostfile'}" or die ("can't open hostfile $opt->{'hostfile'}");
while (<FH>) {
	chomp;
	push @hosts, $_;
}

print "===> Hosts read from the file : \n" if $opt->{'verbose'};
print Dumper (@hosts) if $opt->{'verbose'};


my @errors;
my $pm = new Parallel::ForkManager($opt->{'workers'});


for my $host (@hosts) {
	my $child_pid = $pm->start;
	if ( $child_pid == 0 ) {	
		my $ssh;
		$ssh = Net::OpenSSH->new($host, %opts);
		if ( $ssh->error ) {
			print STDERR "Couldn't establish SSH connection( " . $host . " ) : ". $ssh->error . "\n" if $opt->{'verbose'};
			push @errors, $host;
		} else {
			 
			my $uuid = $ssh->capture("sysctl -n kern.hostuuid");	
			chomp $uuid;

			printf ( "$0 $$ %16s  %8s %s\n", $host, "uuid", $uuid ) if $opt->{'verbose'};
			
			if ( $opt->{'copy'} ) {
				printf ( "$0 $$ %16s  %8s %s\n", $host, "SCP", "starting copy of $opt->{'copy'} to $host:$opt->{'destdir'} " ) if $opt->{'verbose'};
				$ssh->scp_put($opt->{'copy'}, $opt->{'destdir'});
			}
			
			printf ( "$0 $$ %16s  %8s %s\n", $host, "EXEC", "running $opt->{'cmd'}" ) if $opt->{'verbose'};
			my $h = $ssh->capture($opt->{'cmd'});				
			chomp $h;
			printf ( "$0 $$ %16s  %8s %s\n", $host, "EXECOUT", $h ) if $opt->{'verbose'};
		}

		$pm->finish;	
	}

 	
}

$pm->wait_all_children;

print Dumper (@errors) if $opt->{'verbose'};
