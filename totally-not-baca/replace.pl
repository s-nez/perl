#!/usr/bin/env perl 
use strict;
use warnings;
use feature 'say';

# Wypisywanie danych z haszy na podstawie szablonu

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
    }
);

my $text = '[imie] [nazwisko] ma id = [id]';
foreach my $entry (@dane) {
    say $text =~ s/\[([^\]]+)\]/$entry->{$1}/gr;
}
