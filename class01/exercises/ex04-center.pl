#!/usr/bin/env perl 
use strict;
use warnings;

my @words      = <>;
my $max_length = 0;
foreach (@words) {
    $max_length = length if (length > $max_length);
}

foreach (@words) {
    print ' ' x (($max_length - length) / 2), $_;
}
