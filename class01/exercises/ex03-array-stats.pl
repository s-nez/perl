#!/usr/bin/env perl 
use strict;
use warnings;
use feature 'say';

my ($size, $range) = split ' ', <>;
my @array;
push @array, int rand(2 * $range) - $range for (1 .. $size);

local $" = '][';
say "[@array]";

my $sum = 0;
$sum += $_ foreach (@array);
say "Suma: $sum";
say "Średnia: ", $sum / @array;
