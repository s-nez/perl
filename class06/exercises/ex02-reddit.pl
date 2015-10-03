#!/usr/bin/env perl 
use strict;
use warnings;
use utf8;
use v5.18;
use Reddit::Client;
use Data::Dumper;
use HTML::Entities;
binmode STDOUT, ":utf8";

my $LIMIT = 50;
my $SEPARATOR = '-' x ($LIMIT + 4);
my $reddit = Reddit::Client->new(user_agent   => 'MyApp/1.0');

foreach my $sub (@ARGV) {
    say '-' x (length($sub) + 4);
    say '| ', $sub, ' |';
    say $SEPARATOR;
    my $links = $reddit->fetch_links(subreddit => "/r/$sub", limit => 5);
    foreach my $link (@{ $links->{items} }) {
        my $title = decode_entities($link->{title});
        my $short = substr $title, 0, $LIMIT;
        $short =~ s/...\z/.../ if (length $short < length $title);
        say '| ', $short, ' ' x ($LIMIT - length($short)), ' |';
    }
    say $SEPARATOR;
}
