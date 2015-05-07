#!/usr/bin/env perl 
use strict;
use warnings;
use autodie;

my ($pattern) = @ARGV;
my $count = 0;
opendir my $DH, '.';
while (readdir $DH) {
    next if -d;
    rename $_, $pattern . '-' . $count;
    ++$count;
}
closedir $DH;
