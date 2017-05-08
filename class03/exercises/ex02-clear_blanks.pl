#!/usr/bin/perl
use strict;
use warnings;
use feature qw[ say ];
use autodie;
use File::Temp qw[ tempfile ];
use File::Copy qw[ move ];

my ($source_fname) = @ARGV;
my ($temp_fh, $temp_fname) = tempfile();

my $prev_blank = 0;
open my $source_fh, '<', $source_fname;
while (<$source_fh>) {
    chomp;
    s/\s+\z//;
    if (not length) {
        next if $prev_blank;    # don't print consecutive blanks
        $prev_blank = 1;
    }
    else {
        $prev_blank = 0;
    }

    say $temp_fh $_;
}

close $temp_fh;
close $source_fh;

move $temp_fname => $source_fname;
