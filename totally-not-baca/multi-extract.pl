#!/usr/bin/env perl 
use strict;
use warnings;
use feature 'say';

# Wyciąganie kilku parametrów w dowolnej kolejności ze znacznika

while (<DATA>) {
    print;
    if (m{<text\s+(?:(?:p1="(?<p1>\w+)"|p2="(?<p2>\w+)")\s*)+/>}) {
        say 'p1=', $+{p1} // 'NOT FOUND';
        say 'p2=', $+{p2} // 'NOT FOUND';
    }
    print "\n";
}

__DATA__
<text p1="12" p2="id" />
<text p2="name"   p1="test"/>
<text p1="solo"/>
