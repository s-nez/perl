#!/usr/bin/env perl 
use strict;
use warnings;
use feature 'say';

my %counter;
while (<>) {
    s{<(\w+)>}{"<$1-" . $counter{$1}++ . '>'}ge;
    print;
}
