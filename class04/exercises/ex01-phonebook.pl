#!/usr/bin/env perl 
use strict;
use warnings;
use autodie;
use feature 'say';

@ARGV or die "You need to specify a filename\n";
my $filename = shift;

open my $FH, '<', $filename;

my %data;
while (<$FH>) {
    chomp;
    my ($name, $phone, $city) = split ', ';
    my ($first, $last) = split ' ', $name;
    $name = $last . ' ' . $first;
    push @{ $data{$city} }, { telefon => $phone, nazwisko => $name };
}
close $FH;

my $separator = '-' x 10;
foreach my $city (sort { @{ $data{$b} } <=> @{ $data{$a} } or $a cmp $b } keys %data) {
    say $separator;
    say $city, "\n";
    say foreach map { $_->{nazwisko} . ' - ' . $_->{telefon} }
    sort { $a->{nazwisko} cmp $b->{nazwisko} } @{ $data{$city} };
}
say $separator;
