#!/usr/bin/env perl
# przykład splita
use strict;
use warnings;
use feature 'say';
use Data::Dumper;

my $string = q{id;imie;nazwisko};

my $sep = ';';

my @arr = split $sep, $string;

local $" = '][';
say "[@arr]";


