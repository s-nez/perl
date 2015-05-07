#!/usr/bin/env perl 
use strict;
use warnings;
use autodie;
use feature 'say';

my ($file_a, $file_b) = @ARGV;
open my $FHA, '<', $file_a;
open my $FHB, '<', $file_b;

my $diff = 0;
while (not eof $FHA and not eof $FHB) {
    my ($line_a, $line_b) = (scalar <$FHA>, scalar <$FHB>);
    if ($line_a ne $line_b) {
        say "Line $.:";
        print "< $line_a";
        say '---';
        print "> $line_b";
        $diff = 1;
    }
}

$diff = 1 unless (eof $FHA and eof $FHB);
say "Files $file_a and $file_b are identical" unless $diff;

close $FHA;
close $FHB;
