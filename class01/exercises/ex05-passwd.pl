#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';

my $user_count = 0;
while (<>) {
    my ($username, undef, $uid, undef, $fullname) = split ':';
    if (1000 <= $uid and $uid <= 60000) {
        say $username, ': ', $fullname;
        ++$user_count;
    }
}
say 'Liczba użytkowników: ', $user_count;
