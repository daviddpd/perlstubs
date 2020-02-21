use strict;
use warnings;
use Data::Dumper::Simple;

use Getopt::Long::Descriptive;
use NetAddr::IP;
use YAML;
my ($opt, $usage) = describe_options(
	'%c %o',
	[ 'help|h', "help, print usage", ],
	[ 'ipv4', "print ipv4 "],
	[ 'ipv6', "print ipv6" ],
#	[ 'outdir|o=s', "Output Directory", { required => 1 } ],
	
);
# rfc3849 IPv6 Address Prefix Reserved for Documentation
# my $ipv6 = "2001:DB8::/32";
my $ipv6 = "2001:DB8::/48";
# rfc5737  IPv4 Address Blocks Reserved for Documentation
#    192.0.2.0/24 (TEST-NET-1)
#    198.51.100.0/24 (TEST-NET-2)
#    203.0.113.0/24 (TEST-NET-3)

my $ipv4 = "198.51.100.0/24";
    
my $i4 = new NetAddr::IP->new($ipv4);
my $i6 = new NetAddr::IP->new($ipv6);
printf ( " %24s %48s\n",  'NetAddr::IP->new (v4)', $i4 ) if $opt->ipv4;
printf ( " %24s %48s\n",  'NetAddr::IP->new (v6)', $i6 ) if $opt->ipv6;

# Returns a new object referring to the broadcast address of a given subnet. The broadcast address has all ones in all the bit positions where the netmask has zero bits. This is normally used to address all the hosts in a given subnet.
print "\n";
printf ( " %24s %48s\n",  '->broadcast',  $i4->broadcast() );
printf ( " %24s %48s\n",  '->broadcast', $i6->broadcast() );
# 
# ->network()
# Returns a new object referring to the network address of a given subnet. A network address has all zero bits where the bits of the netmask are zero. Normally this is used to refer to a subnet.

print "\n";
printf ( " %24s %48s\n",  '->network',  $i4->network() );
printf ( " %24s %48s\n",  '->network', $i6->network() );


# ->addr()
# Returns a scalar with the address part of the object as an IPv4 or IPv6 text string as appropriate. This is useful for printing or for passing the address part of the NetAddr::IP object to other components that expect an IP address. If the object is an ipV6 address or was created using ->new6($ip) it will be reported in ipV6 hex format otherwise it will be reported in dot quad format only if it resides in ipV4 address space.

print "\n";
printf ( " %24s %48s\n",  '->addr',  $i4->addr() );
printf ( " %24s %48s\n",  '->addr', $i6->addr() );

# ->mask()
# Returns a scalar with the mask as an IPv4 or IPv6 text string as described above.

print "\n";
printf ( " %24s %48s\n",  '->mask',  $i4->mask() );
printf ( " %24s %48s\n",  '->mask', $i6->mask() );

# ->masklen()
# Returns a scalar the number of one bits in the mask.

print "\n";
printf ( " %24s %48s\n",  '->masklen',  $i4->masklen() );
printf ( " %24s %48s\n",  '->masklen', $i6->masklen() );

# ->bits()
# Returns the width of the address in bits. Normally 32 for v4 and 128 for v6.

print "\n";
printf ( " %24s %48s\n",  '->bits',  $i4->bits() );
printf ( " %24s %48s\n",  '->bits', $i6->bits() );

# ->version()
# Returns the version of the address or subnet. Currently this can be either 4 or 6.

print "\n";
printf ( " %24s %48s\n",  '->version',  $i4->version() );
printf ( " %24s %48s\n",  '->version', $i6->version() );

# ->cidr()
# Returns a scalar with the address and mask in CIDR notation. A NetAddr::IP object stringifies to the result of this function. (see comments about ->new6() and ->addr() for output formats)

print "\n";
printf ( " %24s %48s\n",  '->cidr',  $i4->cidr() );
printf ( " %24s %48s\n",  '->cidr', $i6->cidr() );

# ->aton()
# Returns the address part of the NetAddr::IP object in the same format as the inet_aton() or ipv6_aton function respectively. If the object was created using ->new6($ip), the address returned will always be in ipV6 format, even for addresses in ipV4 address space.

print "\n";
	
printf ( " %24s %48s\n",  '->aton',  "not printable" );  #$i4->aton() );
printf ( " %24s %48s\n",  '->aton',  "not printable" ); # $i6->aton() );


# ->range()
# Returns a scalar with the base address and the broadcast address separated by a dash and spaces. This is called range notation.
print "\n";
printf ( " %12s %60s\n",  '->range',  $i4->range() );
printf ( " %12s %60s\n",  '->range', $i6->range() );



# 
# ->prefix()
# Returns a scalar with the address and mask in ipV4 prefix representation. This is useful for some programs, which expect its input to be in this format. This method will include the broadcast address in the encoding.

print "\n";
printf ( " %24s %48s\n",  '->prefix',  $i4->prefix() );
printf ( " %24s %48s\n",  '->prefix',  "n/a" ); # $i6->prefix() );


# ->nprefix()
# Just as ->prefix(), but does not include the broadcast address.

print "\n";
printf ( " %24s %48s\n",  '->nprefix',  $i4->nprefix() );
printf ( " %24s %48s\n",  '->nprefix', "n/a" ); # $i6->nprefix() );

# ->numeric()
# When called in a scalar context, will return a numeric representation of the address part of the IP address. 
# When called in an array contest, it returns a list of two elements. The first element is as described, 
# the second element is the numeric representation of the netmask.

#print "\n";
#print Dumper ( $i4->numeric() );
#print Dumper ( $i6->numeric() );
#printf ( " %24s %48s\n",  '->numeric',  join ( " " , $i4->numeric() ) );
#printf ( " %24s %48s\n",  '->numeric',  join ( " ", $i6->numeric() ) );

# 
# This method is essential for serializing the representation of a subnet.
# 
# ->bigint()
# When called in scalar context, will return a Math::BigInt representation of the address part of the IP address. When called in an array context, it returns a list of two elements, The first element is as described, the second element is the Math::BigInt representation of the netmask.
# 
# ->wildcard()
# When called in a scalar context, returns the wildcard bits corresponding to the mask, in dotted-quad or ipV6 format as applicable.
# 
# When called in an array context, returns a two-element array. The first element, is the address part. The second element, is the wildcard translation of the mask.
# 
# ->short()
# Returns the address part in a short or compact notation.
# 
# (ie, 127.0.0.1 becomes 127.1).
# Works with both, V4 and V6.
# 
# ->canon()
# Returns the address part in canonical notation as a string. For ipV4, this is dotted quad, and is the same as the return value from "->addr()". For ipV6 it is as per RFC5952, and is the same as the LOWER CASE value returned by "->short()".
# 
# ->full()
# Returns the address part in FULL notation for ipV4 and ipV6 respectively.
# 
# i.e. for ipV4
#   0000:0000:0000:0000:0000:0000:127.0.0.1
#  
#      for ipV6
#   0000:0000:0000:0000:0000:0000:0000:0000
# To force ipV4 addresses into full ipV6 format use:
# 
# ->full6()
# Returns the address part in FULL ipV6 notation
# 
# ->full6m()
# Returns the mask part in FULL ipV6 notation
# 
# $me->contains($other)
# Returns true when $me completely contains $other. False is returned otherwise and undef is returned if $me and $other are not both NetAddr::IP objects.
# 
# $me->within($other)
# The complement of ->contains(). Returns true when $me is completely contained within $other.
# 
# Note that $me and $other must be NetAddr::IP objects.
# 
# C->is_rfc1918()>
# Returns true when $me is an RFC 1918 address.
# 
# 10.0.0.0      -   10.255.255.255  (10/8 prefix)
# 172.16.0.0    -   172.31.255.255  (172.16/12 prefix)
# 192.168.0.0   -   192.168.255.255 (192.168/16 prefix)
# ->is_local()
# Returns true when $me is a local network address.
# 
#       i.e.    ipV4    127.0.0.0 - 127.255.255.255
# or            ipV6    === ::1
# ->splitref($bits,[optional $bits1,$bits2,...])
# Returns a reference to a list of objects, representing subnets of bits mask produced by splitting the original object, which is left unchanged. Note that $bits must be longer than the original mask in order for it to be splittable.
# 
# ERROR conditions:
# 
# ->splitref will DIE with the message 'netlimit exceeded'
#   if the number of return objects exceeds 'netlimit'.
#   See function 'netlimit' above (default 2**16 or 65536 nets).
#  
# ->splitref returns undef when C<bits> or the (bits list)
#   will not fit within the original object.
#  
# ->splitref returns undef if a supplied ipV4, ipV6, or NetAddr
#   mask in inappropriately formatted,
# bits may be a CIDR mask, a dot quad or ipV6 string or a NetAddr::IP object. If bits is missing, the object is split for into all available addresses within the ipV4 or ipV6 object ( auto-mask of CIDR 32, 128 respectively ).
# 
# With optional additional bits list, the original object is split into parts sized based on the list. NOTE: a short list will replicate the last item. If the last item is too large to for what remains of the object after splitting off the first parts of the list, a "best fits" list of remaining objects will be returned based on an increasing sort of the CIDR values of the bits list.
# 
# i.e.  my $ip = new NetAddr::IP('192.168.0.0/24');
#       my $objptr = $ip->split(28, 29, 28, 29, 26);
#  
#  has split plan 28 29 28 29 26 26 26 28
#  and returns this list of objects
#  
#       192.168.0.0/28
#       192.168.0.16/29
#       192.168.0.24/28
#       192.168.0.40/29
#       192.168.0.48/26
#       192.168.0.112/26
#       192.168.0.176/26
#       192.168.0.240/28
# NOTE: that /26 replicates twice beyond the original request and /28 fills the remaining return object requirement.
# 
# ->rsplitref($bits,[optional $bits1,$bits2,...])
# ->rsplitref is the same as ->splitref above except that the split plan is applied to the original object in reverse order.
# 
# i.e.  my $ip = new NetAddr::IP('192.168.0.0/24');
#       my @objects = $ip->split(28, 29, 28, 29, 26);
#  
#  has split plan 28 26 26 26 29 28 29 28
#  and returns this list of objects
#  
#       192.168.0.0/28
#       192.168.0.16/26
#       192.168.0.80/26
#       192.168.0.144/26
#       192.168.0.208/29
#       192.168.0.216/28
#       192.168.0.232/29
#       192.168.0.240/28
# ->split($bits,[optional $bits1,$bits2,...])
# Similar to ->splitref above but returns the list rather than a list reference. You may not want to use this if a large number of objects is expected.
# 
# ->rsplit($bits,[optional $bits1,$bits2,...])
# Similar to ->rsplitref above but returns the list rather than a list reference. You may not want to use this if a large number of objects is expected.
# 
# ->hostenum()
# Returns the list of hosts within a subnet.
# 
# ERROR conditions:
# 
# ->hostenum will DIE with the message 'netlimit exceeded'
#   if the number of return objects exceeds 'netlimit'.
#   See function 'netlimit' above (default 2**16 or 65536 nets).
# ->hostenumref()
# Faster version of ->hostenum(), returning a reference to a list.
# 
# NOTE: hostenum and hostenumref report zero (0) useable hosts in a /31 network. This is the behavior expected prior to RFC 3021. To report 2 useable hosts for use in point-to-point networks, use :rfc3021 tag.
# 
# use NetAddr::IP qw(:rfc3021);
# This will cause hostenum and hostenumref to return two (2) useable hosts in a /31 network.
# 
# $me->compact($addr1, $addr2, ...)
# @compacted_object_list = Compact(@object_list)
# Given a list of objects (including $me), this method will compact all the addresses and subnets into the largest (ie, least specific) subnets possible that contain exactly all of the given objects.
# 
# Note that in versions prior to 3.02, if fed with the same IP subnets multiple times, these subnets would be returned. From 3.02 on, a more "correct" approach has been adopted and only one address would be returned.
# 
# Note that $me and all $addr's must be NetAddr::IP objects.
# 
# $me->compactref(\@list)
# $compacted_object_list = Compact(\@list)
# As usual, a faster version of ->compact() that returns a reference to a list. Note that this method takes a reference to a list instead.
# 
# Note that $me must be a NetAddr::IP object.
# 
# $me->coalesce($masklen, $number, @list_of_subnets)
# $arrayref = Coalesce($masklen,$number,@list_of_subnets)
# Will return a reference to list of NetAddr::IP subnets of $masklen mask length, when $number or more addresses from @list_of_subnets are found to be contained in said subnet.
# 
# Subnets from @list_of_subnets with a mask shorter than $masklen are passed "as is" to the return list.
# 
# Subnets from @list_of_subnets with a mask longer than $masklen will be counted (actually, the number of IP addresses is counted) towards $number.
# 
# Called as a method, the array will include $me.
# 
# WARNING: the list of subnet must be the same type. i.e ipV4 or ipV6
# 
# ->first()
# Returns a new object representing the first usable IP address within the subnet (ie, the first host address).
# 
# ->last()
# Returns a new object representing the last usable IP address within the subnet (ie, one less than the broadcast address).
# 
# ->nth($index)
# Returns a new object representing the n-th usable IP address within the subnet (ie, the n-th host address). If no address is available (for example, when the network is too small for $index hosts), undef is returned.
# 
# Version 4.00 of NetAddr::IP and version 1.00 of NetAddr::IP::Lite implements ->nth($index) and ->num() exactly as the documentation states. Previous versions behaved slightly differently and not in a consistent manner. See the README file for details.
# 
# To use the old behavior for ->nth($index) and ->num():
# 
# use NetAddr::IP::Lite qw(:old_nth);
#  
# old behavior:
# NetAddr::IP->new('10/32')->nth(0) == undef
# NetAddr::IP->new('10/32')->nth(1) == undef
# NetAddr::IP->new('10/31')->nth(0) == undef
# NetAddr::IP->new('10/31')->nth(1) == 10.0.0.1/31
# NetAddr::IP->new('10/30')->nth(0) == undef
# NetAddr::IP->new('10/30')->nth(1) == 10.0.0.1/30
# NetAddr::IP->new('10/30')->nth(2) == 10.0.0.2/30
# NetAddr::IP->new('10/30')->nth(3) == 10.0.0.3/30
# Note that in each case, the broadcast address is represented in the output set and that the 'zero'th index is alway undef except for a point-to-point /31 or /127 network where there are exactly two addresses in the network.
# 
# new behavior:
# NetAddr::IP->new('10/32')->nth(0)  == 10.0.0.0/32
# NetAddr::IP->new('10.1/32'->nth(0) == 10.0.0.1/32
# NetAddr::IP->new('10/31')->nth(0)  == 10.0.0.0/31
# NetAddr::IP->new('10/31')->nth(1)  == 10.0.0.1/31
# NetAddr::IP->new('10/30')->nth(0) == 10.0.0.1/30 
# NetAddr::IP->new('10/30')->nth(1) == 10.0.0.2/30 
# NetAddr::IP->new('10/30')->nth(2) == undef
# Note that a /32 net always has 1 usable address while a /31 has exactly two usable addresses for point-to-point addressing. The first index (0) returns the address immediately following the network address except for a /31 or /127 when it return the network address.
# 
# ->num()
# As of version 4.42 of NetAddr::IP and version 1.27 of NetAddr::IP::Lite a /31 and /127 with return a net num value of 2 instead of 0 (zero) for point-to-point networks.
# 
# Version 4.00 of NetAddr::IP and version 1.00 of NetAddr::IP::Lite return the number of usable IP addresses within the subnet, not counting the broadcast or network address.
# 
# Previous versions worked only for ipV4 addresses, returned a maximum span of 2**32 and returned the number of IP addresses not counting the broadcast address. (one greater than the new behavior)
# 
# To use the old behavior for ->nth($index) and ->num():
# 
# use NetAddr::IP::Lite qw(:old_nth);
# WARNING:
# 
# NetAddr::IP will calculate and return a numeric string for network ranges as large as 2**128. These values are TEXT strings and perl can treat them as integers for numeric calculations.
# 
# Perl on 32 bit platforms only handles integer numbers up to 2**32 and on 64 bit platforms to 2**64.
# 
# If you wish to manipulate numeric strings returned by NetAddr::IP that are larger than 2**32 or 2**64, respectively, you must load additional modules such as Math::BigInt, bignum or some similar package to do the integer math.
# 
# ->re()
# Returns a Perl regular expression that will match an IP address within the given subnet. Defaults to ipV4 notation. Will return an ipV6 regex if the address in not in ipV4 space.
# 
# ->re6()
# Returns a Perl regular expression that will match an IP address within the given subnet. Always returns an ipV6 regex.
# 
