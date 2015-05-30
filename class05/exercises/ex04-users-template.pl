#!/usr/bin/env perl 
use strict;
use warnings;
use feature qw(state say);

my (%users, @template, @selected);
my $state  = 'start';
my %parser = (
    start => sub {
        my $line = shift;
        if ($line =~ /<users>/) {
            $state = 'users';
        } elsif ($line =~ /<template>/) {
            $state = 'template';
        } elsif ($line =~ /<select>/) {
            $state = 'select';
        }
    },
    users => sub {
        my $line = shift;
        state($current_user, %tr);
        %tr = (lvl => 'level', 'e-mail' => 'email');

        if ($line =~ /\[(\w+)\]/) {
            $current_user = $1;
        } elsif ($line =~ m(</users>)) {
            $state = 'start';
        } elsif ($line =~ /(\w+)\s*=\s*["'](.+?)["']/) {
            $users{$current_user}{ $tr{$1} // $1 } = $2;
        }
    },
    template => sub {
        my $line = shift;
        if ($line =~ m(</template>)) {
            $state = 'start';
        } else {
            push @template, $line;
        }
    },
    select => sub {
        my $line = shift;
        if ($line =~ m(</select>)) {
            $state = 'start';
        } else {
            push @selected, split ' ', $line;
        }
    }
);
until (eof) {
    my $line = <>;
    next if $line =~ /\A\s*\z/;
    $parser{$state}->($line);
}

foreach my $user (sort { $users{$b}{level} <=> $users{$a}{level} } @selected) {
    foreach my $line (@template) {
        print $line =~ s/\[(\w+)\]/$users{$user}{$1}/gr;
    }
    print "\n";
}
