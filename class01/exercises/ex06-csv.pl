#!/usr/bin/env perl 
use strict;
use warnings;
use feature 'say';

@ARGV or die "No filename specified";

my @rows = <>;
my @lengths;

foreach (@rows) {
    chomp;
    my @entries = split ',';
    while (my ($index, $entry) = each @entries) {
        if (not defined $lengths[$index] or length $entry > $lengths[$index]) {
            $lengths[$index] = length $entry;
        }
    }
}

my $separator = '+';
foreach my $max_length (@lengths) {
    $separator .= ('-' x $max_length) . '+';
}

my ($pass, $pass_count) = ('hunter2', 0);
my $pass_repl = '*' x length $pass;

say $separator;
foreach (@rows) {
    my @entries = split ',';
    while (my ($index, $entry) = each @entries) {
        print '|', ' ' x ($lengths[$index] - length($entry));
        if ($entry eq $pass) {
            print $pass_repl;
            ++$pass_count;
        } else {
            print $entry;
        }
    }
    print "|\n", $separator, "\n";
}

say "\n", "Wystąpienia hasła: $pass_count" if $pass_count > 0;
