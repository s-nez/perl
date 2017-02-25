#!/usr/bin/env perl 
use strict;
use warnings;
use feature 'say';

my %count;
while (<>) {
    foreach my $word (split) {
        ++$count{$word};
    }
}

foreach my $key (keys %count) {
    say "$key: $count{$key}";
}
