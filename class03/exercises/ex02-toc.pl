#!/usr/bin/perl
use strict;
use warnings;
use autodie;
use feature qw[ say ];

my ($source_file) = @ARGV;
open my $fh, '+<', $source_file;

my @toc;
while (<$fh>) {
    if (/^(#+)\s*(.*)/) {
        my $indent_level = length($1) - 1;
        push @toc, ' ' x ($indent_level * 4) . '* ' . $2;
    }
}

select $fh;
print "\n";
say '# Table of contents';
say foreach @toc;

close $fh;
