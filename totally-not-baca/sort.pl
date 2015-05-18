#!/usr/bin/env perl 
use strict;
use warnings;
use feature 'say';
use Data::Dumper;

# Malejące sortowanie leksykograficzne referencji do haszy
# według konkretnego klucza

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

my $klucz = 'imie';
@dane = sort { $b->{$klucz} cmp $a->{$klucz} } @dane;
print Dumper(\@dane);
