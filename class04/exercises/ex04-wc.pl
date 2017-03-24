#!/usr/bin/env perl 
use strict;
use warnings;
use feature 'say';

my $mode = shift;
if ($mode eq '-l') {
    readline until eof;
    say "Total: $. lines";
} elsif ($mode eq '-w') {
    my $words = 0;
    $words += split while <>;
    say "Total: $words words";
} elsif ($mode eq '-c') {
    my $chars = 0;
    $chars += length while <>;
    say "Total: $chars characters";
} else {
    die "Invalid mode\n";
}
