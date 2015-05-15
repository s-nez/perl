package Utility;
use strict;
use warnings;
use feature 'say';
use autodie;

use Exporter 'import';
our @EXPORT =
  qw (mult_table is_palindrome sum avg center normal_users table_display);

sub mult_table {
    my $n = shift;

    for my $x (1 .. $n) {
        for my $y (1 .. $n) {
            print $x * $y, ' ';
        }
        print "\n";
    }
    return;
}

sub is_palindrome {
    my $word = shift;
    return lc $word eq reverse lc $word;
}

sub sum {
    my $sum = 0;
    $sum += $_ foreach @_;
    return $sum;
}

sub avg {
    return (sum @_) / @_;
}

sub center {
    my $max_length = 0;
    foreach (@_) {
        $max_length = length if (length > $max_length);
    }
    print ' ' x (($max_length - length) / 2), $_ foreach (@_);
    return;
}

sub normal_users {
    open my $PASSWD, '<', '/etc/passwd/';
    my @users;
    while (<$PASSWD>) {
        my ($username, undef, $uid) = split ':';
        push @users, $username if (1000 <= $uid and $uid <= 60000);
    }
    close $PASSWD;
    return @users;
}

sub table_display {
    open my $CSV, '<', shift;
    my @rows = <$CSV>;
    close $CSV;

    my @lengths;
    foreach (@rows) {
        chomp;
        my @entries = split ',';
        while (my ($index, $entry) = each @entries) {
            no warnings 'uninitialized'; # purposeful use of undef in comparison
            if (length $entry > $lengths[$index]) {
                $lengths[$index] = length $entry;
            }
        }
    }

    my $separator = '+' . join('+', map { '-' x $_ } @lengths) . '+';

    say $separator;
    foreach (@rows) {
        my @entries = split ',';
        while (my ($index, $entry) = each @entries) {
            print '|', ' ' x ($lengths[$index] - length($entry));
            print $entry;
        }
        print "|\n", $separator, "\n";
    }
    return;
}
