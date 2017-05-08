#!/usr/bin/perl
use strict;
use warnings;
use feature qw[ say ];
use File::Count;

die "Specify two arguments: -mode filename\n" unless @ARGV == 2;
my ($mode, $file) = @ARGV;

if ($mode eq '-c') {
    say File::Count::chars($file);
}
elsif ($mode eq '-l') {
    say File::Count::lines($file);
}
elsif ($mode eq '-w') {
    say File::Count::words($file);
}
else {
    die "Unsupported mode\n";
}
