#!/usr/bin/env perl
use strict;
use warnings;
use feature 'say';
use Data::Dumper; # do wypisywania w ładny sposób złożonych struktur danych

# hasz trzymający naszą bazę danych
my %db =(
	key => 'id',
	cols => [qw(id imie nazwisko)], # osobno trzymamy kolumny, ponieważ w 
									# haszach nie mamy pewności co do 
									# kolejności kluczy
	dane => [ # tablica haszy, które będą naszymi pojedynczymi wierszami
		{ id => 1, 
		  imie => 'Tom', 
          nazwisko => 'Dom'}
		]
);

print Dumper(\%db);

my %row = (id => 2, 
	       imie => 'Walerian', 
		   nazwisko => 'Forsyth');

push @{ $db{dane} }, \%row;

print Dumper(\%db);
