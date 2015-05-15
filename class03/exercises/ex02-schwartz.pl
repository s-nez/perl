#!/usr/bin/env perl 
use strict;
use warnings;
use autodie;
use feature 'say';

open my $PASSWD, '<', '/etc/passwd';

my @entries = map { $_->[0] }
sort { $a->[1] <=> $b->[1] }
map { [ $_, (split ':')[2] ] } <$PASSWD>;

close $PASSWD;
print foreach @entries;
