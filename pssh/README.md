Parallel SSH
=============

So, this gets written over and over again. Here is my
version.

It's not perfect, may be buggy depending on which version
of the modules used.

Like the other things in here, this is a stub, though it feels like a full program,
the intention is that this gets heavily modified and integrated into a bigger application.

Usage Examples:

	`pssh.pl -d -v -w 1 --hostfile test.host --cmd date`

	`pssh.pl -d -v -w 1 --copy run.sh --hostfile test.host --cmd /tmp/run.sh`