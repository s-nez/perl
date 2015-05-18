#!/usr/bin/env perl
use strict;
use warnings;
use feature 'say';
use Data::Dumper;

# zagnieżdżone struktury

my @arr = 1..10;

my $arr_ref = \@arr; #referencja do tablicy @arr
my @refs = ($arr_ref);

push @refs, [qw(a b c)]; 
# push @refs, {abc => 1, haha=> 2}; #przypisanie jeszcze hasza

$refs[3]{id} = 1; # co się stanie? 
				  # Perl się do nas dostosuje i utworzy hasza pod indeksem 3
				  # gdzie dla klucza 'id' przypisze wartość 1

print Dumper(\@refs);
