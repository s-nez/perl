#!/usr/bin/env perl 
use strict;
use warnings;
use feature 'say';

my $N = <>;
foreach my $a (1 .. $N) {
    foreach my $b (1 .. $N) {
        print $a* $b, ' ';
    }
    print "\n";
}
