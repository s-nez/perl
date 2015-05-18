#!/usr/bin/env perl 
use strict;
use warnings;
use feature 'say';

# Wczytanie porcji wejścia kończącej się konkretnym znacznikiem

my @input;
my $text;
while (<DATA>) {
    if (/<text>/) {
        local $/ = '</text>';
        $text = <DATA>;
        chomp $text;
    } else {
        push @input, $_;
    }
}

say 'Input:';
print foreach @input;

say "-" x 10;

say 'Text:';
print $text;

__DATA__
Jakiś nieistotny przedtekst
<text>
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec a diam lectus.
Sed sit amet ipsum mauris. Maecenas congue ligula ac quam viverra nec
consectetur ante hendrerit. Donec et mollis dolor. Praesent et diam eget
libero egestas mattis sit amet vitae augue. Nam tincidunt congue enim, ut
porta lorem lacinia consectetur. Donec ut libero sed arcu vehicula ultricies
a non tortor.
</text>
Jakiś nieistotny potekst
