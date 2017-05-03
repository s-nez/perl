#!/usr/bin/env perl 
use strict;
use warnings;
use feature 'say';

my ($COLOR_START, $COLOR_END) = ("\033[31m", "\033[0m");

die "Not enough arguments\n" unless @ARGV >= 1;
my $search = quotemeta pop;
my $sub_count = 0;
while (<>) {
    $sub_count += s/($search)/${COLOR_START}$1${COLOR_END}/gui;
    print;
}

say "\n$search occurred $sub_count times";
