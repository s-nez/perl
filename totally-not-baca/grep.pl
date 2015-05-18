#!/usr/bin/env perl 
use strict;
use warnings;
use feature 'say';
use Data::Dumper;

# Usuwanie haszy, w których dany klucz pasuje do regexa
my @dane = (
    {
        id       => 1,
        imie     => 'Tom',
        nazwisko => 'Dom'
    },
    {
        id       => 2,
        imie     => 'Jan',
        nazwisko => 'Janowski'
    },
    {
        id       => 3,
        imie     => 'Witold',
        nazwisko => 'Franczewski'
    },
    {
        id       => 4,
        imie     => 'Krzysztof',
        nazwisko => 'Szczur'
    },
);

my ($klucz, $regex) = ('nazwisko', 'i$');
@dane = grep { $_->{$klucz} !~ /$regex/ } @dane;
print Dumper(\@dane);
