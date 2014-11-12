#!/usr/bin/perl

use strict;
use warnings;

# http://search.cpan.org/~szbalint/WWW-Curl-4.17/
# The name might be confusing, it originates from libcurl. This is not an ::Easy module in the sense normally used on CPAN.

use WWW::Curl::Easy;

# http://search.cpan.org/~ovid/Data-Dumper-Simple-0.11/lib/Data/Dumper/Simple.pm
# Data::Dumper::Simple - Easily dump variables with names

use Data::Dumper::Simple;



my $URL 				= 'http://davidpdischer.com';
my $CONNECT_TIMEOUT 	= 5;  # seconds
my $TRANSFER_TIMEOUT 	= 60; # seconds
my $CERTS_DIR 			= "./certs";
my $USERAGENT			= "dpd-libcurl/1";

my $data				= '';

my $curl = WWW::Curl::Easy->new;

$curl->setopt(CURLOPT_URL, $URL );

$curl->setopt(CURLOPT_CONNECTTIMEOUT, $CONNECT_TIMEOUT);
$curl->setopt(CURLOPT_TIMEOUT, $TRANSFER_TIMEOUT);
$curl->setopt(CURLOPT_DNS_CACHE_TIMEOUT, 0);

$curl->setopt(CURLOPT_USERAGENT, $USERAGENT); 

$curl->setopt(CURLOPT_VERBOSE, 1);

$curl->setopt(CURLOPT_WRITEDATA, \$data);

# Set method to POST
# $curl->setopt(CURLOPT_POST, 1);
# $curl->setopt(CURLOPT_POSTFIELDS, $data_str);
# $curl->setopt(CURLOPT_POSTFIELDSIZE, length($data_str));

# use these for client certificate authentication 

# $curl->setopt(CURLOPT_SSLCERT, CERTS_DIR."/sslcert.cert");
# $curl->setopt(CURLOPT_SSLKEY,  CERTS_DIR."/sslkey.key");
# $curl->setopt(CURLOPT_CAINFO,  CERTS_DIR."/cainfo-chain.pem");

# When CURLOPT_SSL_VERIFYPEER is enabled, and the verification 
# fails to prove that the certificate is authentic, the connection 
# fails. When the option is zero, the peer certificate verification succeeds regardless.

# $curl->setopt(CURLOPT_SSL_VERIFYPEER, 0);

my $retcode  = $curl->perform;

if ($retcode == 0) {
	print("[$0] perform ok [$retcode] \n");
	my $response_code = $curl->getinfo(CURLINFO_HTTP_CODE);
	print("[$0] HTTP responde code: $response_code \n");	
} else {
	print("An error happened: $retcode ".$curl->strerror($retcode)." ".$curl->errbuf."\n");
}
        
print " \n\n ==================== HTTP Body (first 256 bytes) ======================== \n\n ";
print substr($data, 0, 256 );
print "\n\n ==================== HTTP Body ======================== \n\n ";



