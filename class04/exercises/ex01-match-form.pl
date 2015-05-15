#!/usr/bin/env perl 
use strict;
use warnings;
use v5.18;

# Wyrażenia do uzupełnienia
my $blank        = qr//;
my $integer      = qr//;
my $float        = qr//;
my $phone_number = qr//;
my $sentence     = qr//;
my $five_l_word  = qr//;
my $dialog_three = qr//;
my $web_address  = qr//;

###########################################
# Tests - do not touch, there be monsters #
###########################################
my @tasks = (
    {
        name        => 'Blank',
        regex       => $blank,
        tests_true  => [ '', '       ', "   \n \n", "  \n", "\n" ],
        tests_false => [ '.', 'rewrw', '    sd', ' sdf ', "\nd", ' . ' ]
    },
    {
        name        => 'Phone number',
        regex       => $phone_number,
        tests_true  => [ '123-456-789', "111-111-111\n" ],
        tests_false => [
            '',                       '-123-123',
            'bduibgeruge123-123-123', 'avd-fds-vdf',
            '123 123 123',            '566\-666\-543',
            '12-431-432',
        ]
    },
    {
        name        => 'Integer',
        regex       => $integer,
        tests_true  => [ '1', '0', '123689', "111111\n" ],
        tests_false => [
            '', "123\n143", 'word', '123.432', '.34', '123.', 'fds123', '14dsf'
        ]
    },
    {
        name       => 'Float',
        regex      => $float,
        tests_true => [ '1', '0', '123.432', '123689', "111111\n" ],
        tests_false =>
          [ '', "123\n143", 'word', '.34', '123.', 'fds123', '14dsf' ]
    },
    {
        name       => 'Sentence',
        regex      => $sentence,
        tests_true => [
            'To be or not to be?',
            'This is the question.',
            'More of this.',
            'Single.'
        ],
        tests_false => [
            '', '.', ',', '?', '.?', 'to be', 'numbers11111111',
            'end in a coma,',
            'Beat it. ', 'Double sentence. For the win.'
        ]
    },
    {
        name  => 'Five-letter word',
        regex => $five_l_word,
        tests_true =>
          [ 'abcde', 'Some words here', 'W W W W WORDS', 'jokes are fun' ],
        tests_false => [
            '',                    '.....',
            'To be or not to be?', 'This is the question.',
            'Single.',             'More of this.',
            '123abcde456',         'lolololololololo'
        ]
    },
    {
        name       => 'Dialog with three words',
        regex      => $dialog_three,
        tests_true => [
            'Person: hue hue hue',
            'Someone: he he he he he he, and sth else',
            'Man: words words words not words words words'
        ],
        tests_false => [
            '',
            'Lulz lolololo',
            'Test: wrong wong won',
            'starts here and dialog: here here here',
            'dialog: break test test test test'
        ]
    },
    {
        name       => 'Web address',
        regex      => $web_address,
        tests_true => [
            'www.perl.org',           'uj.edu.pl',
            'http://www.youtube.com', 'guardian.co.uk',
            'wp.pl',                  'https://www.github.com'
        ],
        tests_false => [
            '',              'www.poland.pl not right',
            'www,test,bleh', 'white space.com',
            '@%&*#$.pl',     '.hue.hue',
            'singleword',    'http',
            'www.http://test.org'
        ]
    },
);

sub colorize {
    my ($color, $text) = @_;
    my ($HICOLOR, $RESET) = ("\033[1m", "\033[0m");
    my %colors = (
        WHITE  => '',
        RED    => "\033[31m",
        GREEN  => "\033[32m",
        YELLOW => "\033[33m"
    );
    return $HICOLOR . $colors{$color} . $text . $RESET;
}

foreach my $task (@tasks) {
    say colorize('WHITE', $task->{name} . "\n" . '=' x length $task->{name});
    if ($task->{regex} eq qr//) {
        say 'Not implemented';
        next;
    }

    while (my ($number, $test) = each @{ $task->{tests_true} }) {
        print "Match test #$number: ";
        if ($test =~ $task->{regex}) {
            say colorize('GREEN', 'OK');
        } else {
            say colorize('RED', 'FAIL'), ': "',
              $test =~ s{\n}{colorize('YELLOW', '\n')}ger, '"';
        }
    }
    print "\n";

    while (my ($number, $test) = each @{ $task->{tests_false} }) {
        print "No match test #$number: ";
        if ($test !~ $task->{regex}) {
            say colorize('GREEN', 'OK');
        } else {
            say colorize('RED', 'FAIL'), ': "',
              $test =~ s{\n}{colorize('YELLOW', '\n')}ger, '"';
        }
    }
    print "\n";
}
