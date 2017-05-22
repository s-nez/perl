#!/usr/bin/perl
use strict;
use warnings;
use feature qw[ say ];
use autodie;
use Getopt::Long;
use Pod::Usage;

my %modes = (
    at => { A => 1, T => 1, G => 0, C => 0 },
    gc => { A => 0, T => 0, G => 1, C => 1 },
);
my (%arg, $filename);
{
    local $SIG{__DIE__} =
      sub { pod2usage -noperldoc => 1, -verbose => 1, -msg => $_[0] };
    GetOptions(\%arg, qw/
        mode=s
        from=i
        to=i
        size=i
    /) or die "Invalid arguments\n";

    foreach my $required (qw[ mode from to size ]) {
        die "Missing --$required\n" unless defined $arg{$required};
    }
    foreach my $positive (qw[ from to size ]) {
        die "Invalid --$positive: $arg{$positive}\n" unless $arg{$positive} > 0;
    }
    die "Invalid mode: $arg{mode}\n" unless exists $modes{ $arg{mode} };

    $filename = shift or die "No filename specified\n";
}

open my $fh, '<', $filename;
my ($from, $to, $size) = @arg{qw[ from to size ]};

my @buffer;
my $add_new_entry = do {
    my $subtotal    = 0;
    my $num_val_ref = $modes{ $arg{mode} };
    sub {
        my ($entry) = @_;
        push @buffer, $entry;
        $subtotal += $num_val_ref->{$entry};
        if (@buffer > $size) {
            my $value_removed = shift @buffer;
            $subtotal -= $num_val_ref->{$value_removed};
        }
        return if @buffer < $size;    # not enough values yet
        return $subtotal;
    };
};

my $percentage_match = sub {
    my ($subtotal) = @_;
    my $percentage = ($subtotal / $size) * 100;
    return ($from <= $percentage and $percentage <= $to);
};

while (<$fh>) {
    chomp;

    foreach my $entry (split //) {
        my $subtotal = $add_new_entry->($entry);
        if (defined $subtotal and $percentage_match->($subtotal)) {
            say join '', @buffer;
        }
    }
}

close $fh;

__END__
=pod

=head1 NAME

ex01_seq_regions.pl - detect regions with given AT or CG density in a DNA sequence

=head1 SYNOPSIS

Find all regions of size 80 with GC density in 55%-65% range:

  $ perl ex01_seq_regions.pl --from 55 --to 65 --size 80 --mode gc sequence.txt

=head1 ARGUMENTS

=head2 --mode [at|gc]

Specify whether AT or GC density is to be checked.

=head2 --size [INT]

The size of regions to check.

=head2 --from [INT]

Beginning (inclusive) of the desired range.

=head2 --to [INT]

End (inclusive) of the desired range.

=head2 --help

Display this help.

=cut
