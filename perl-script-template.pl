#!/usr/bin/env perl
# -*-mode:cperl -*-
=pod

Description:
This script makes developer happier.

Usage:
1. edit the parts under the section '#-- arguments --'.
2. run script

Date created: 2013-07
Author: Fedor Sumkin

=cut
use strict;
use warnings;

use Data::Dumper qw ( Dumper );
use Getopt::Long qw ( GetOptions );

use 5.008003; # may be newer
########################################################################
my $VERSION = '0.8.0';

## Set defaults for all the options, then read them in from command line
my %arg = (
    verbose => 0,
    quiet => 0,
    debug => 0,
    help => 0,
    mode => 0
);

########################################################################
my $result = GetOptions (
   \%arg,
   'verbose',
   'quiet',
   'debug',
   'help|h',
   'mode=s'
  ) or help();

$arg{help} and help();

print "================\n";
print "ARG ARRAY => ".Dumper \%arg;
print "================\n";
########################################################################

sub main
{
    if($arg{mode} eq 'god') {
        print "God mode\n";
        exit 0;
    }


}

########################################################################
sub help 
{
    print "Usage: $0 configfile [options]\n";
    print "    For full documentation, please visit:\n";
    print "    http://some_host\n";
    exit 0;
}

main();