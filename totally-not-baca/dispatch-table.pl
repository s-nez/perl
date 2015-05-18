#!/usr/bin/env perl
# Przykład działania `dispatch table` w kontekście zadania z BaCy
use strict;
use warnings;
use feature 'say';
use Data::Dumper;

my %db =(
	key => 'id',
	cols => [qw(id imie nazwisko)],
	dane => [
		{ id => 1, 
		  imie => 'Tom', 
                  nazwisko => 'Dom'}
		]
);


my $state = 'start';
my %parser = (
	start => sub {
		my $line = shift;
		if ($line =~ m{dane}){
			$state = 'key_sep';
		}
	},
	key_sep => sub{
		my $line = shift;
		if ($line =~ m{<klucz}){
				
		}elsif ($line =~ m{<plik}){
			$state = 'header';
		}
	},
	header => sub {
		my $line = shift;
		$state = 'dane';
	},
	dane => sub {
		my $line = shift;
		if ($line =~ m{</plik>}){
			$state = 'finish';
		}
	}
);

# ogólne wczytywanie pliku
while (not eof and $state ne 'finish'){
	my $line = <>;
	print "$state: $line";
	$parser{$state}->($line);
}
