#!/usr/bin/env perl 
use strict;
use warnings;
use feature 'say';
use Term::ANSIColor qw[ color ];

my ($COLOR_START, $COLOR_END) = (color('red'), color('reset'));

die "Not enough arguments\n" unless @ARGV >= 1;
my $search = quotemeta pop;
my $sub_count = 0;
while (<>) {
    $sub_count += s/($search)/${COLOR_START}$1${COLOR_END}/gui;
    print;
}

say "\n$search occurred $sub_count times";
