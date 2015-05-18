#!/usr/bin/env perl
# przykład użycia funkcji shift
use strict;
use warnings;
use feature 'say';
use Data::Dumper;

my @arr = 1..3;

say "@arr";

my $scalar = shift @arr;
say "@arr";
say "$scalar";
