#!/usr/bin/env perl 
use strict;
use warnings;

my $n = <STDIN>;
foreach my $x (1 .. $n) {
    foreach my $y (1 .. $n) {
        print $x * $y, ' ';
    }
    print "\n";
}
