#!/usr/bin/env perl 
use strict;
use warnings;
use feature 'say';

my %count;
while (<>) {
    chomp;
    my ($ip) = /(\d{1,3}(?:\.\d{1,3}){3})\Z/;
    ++$count{$ip};
}

foreach my $ip (sort { $count{$b} <=> $count{$a} } keys %count) {
    say "$ip: $count{$ip}";
}
