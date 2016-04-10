#!/usr/bin/env perl 
use strict;
use warnings;
use feature 'say';

my @palindromes;
while (<>) {
    chomp;
    foreach my $word (split ' ') {
        push @palindromes, $word if lc $word eq reverse lc $word;
    }
}

say 'Palindromy:';
say foreach @palindromes;
