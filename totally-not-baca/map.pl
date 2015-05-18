#!/usr/bin/env perl
# Przykład działania funkcji map 
use strict;
use warnings;
use feature 'say';
use Data::Dumper;
my @cols = ('id', 'imie', 'nazwisko');
my @data = (1,'Tom', 'Dom');

my %raw = map {$_ => shift @data} @cols;

print Dumper(\%raw);
