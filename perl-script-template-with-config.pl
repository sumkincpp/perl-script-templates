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
my $CONFIG_FILE = 'config.cfg';

## Set defaults for all the options, then read them in from command line
my %arg = (
    verbose => 0,
    quiet => 0,
    debug => 0,
    help => 0,
    mode => 0
);
########################################################################
# Get our configuration information
if (my $err = ReadCfg($CONFIG_FILE)) {
    print(STDERR $err, "\n");
    exit(1);
}

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

print "================\n";
print "CFG ARRAY => ".Dumper \%CFG::CFG;
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
# Read a configuration file
#   The arg can be a relative or full path, or
#   it can be a file located somewhere in @INC.
sub ReadCfg
{
    my $file = $_[0];

    our $err;

    {   # Put config data into a separate namespace
        package CFG;

        # Process the contents of the config file
        my $rc = do($file);

        # Check for errors
        if ($@) {
            $::err = "ERROR: Failure compiling '$file' - $@";
        } elsif (! defined($rc)) {
            $::err = "ERROR: Failure reading '$file' - $!";
        } elsif (! $rc) {
            $::err = "ERROR: Failure processing '$file'";
        }
    }

    return ($err);
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