#!/usr/bin/env perl 
use strict;
use warnings;
use feature qw[ say ];
use Term::ANSIColor qw[ colored ];

# Wyrażenia do uzupełnienia
my $blank           = qr//;
my $integer         = qr//;
my $float           = qr//;
my $phone_number    = qr//;
my $sentence        = qr//;
my $five_l_word     = qr//;
my $dialog_three    = qr//;
my $web_address     = qr//;
my $nostart_comment = qr//;
my $not_evil_nums   = qr//;
my $read_frame      = qr//;

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
          [ '', "123\n143", 'word', '.34', '12,34', '123.', 'fds123', '14dsf' ]
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
    {
        name       => 'No-start comment',
        regex      => $nostart_comment,
        tests_true => [
            ' # comment',
            ' #',
            'code much code # and comment',
            'this #not this',
            "comment #\n",
            '#bad comment #good comment',
            '# //',
            'other // style',
            'why # not // both',
            '#//', "   \n# cmnt"
        ],
        tests_false => [
            '', '#', '#comment', "#\n", '#', "//comment", 'no comment',
            '/class?', '/|/ was ist das?!'
        ]
    },
    {
        name       => 'Not-evil numbers',
        regex      => $not_evil_nums,
        tests_true => [
            '123123',                '666123',
            "666665",                "98412375439",
            "1236663218402347832\n", "0000000000"
        ],
        tests_false => [
            '', 'rewrw', "\n", '123666', "9543678347534899666", '15', '9866',
            '0', 'onetwothree123'
        ]
    },
    {
        name       => 'Read frame',
        regex      => $read_frame,
        tests_true => [
            'AUGACGAUGAUUUAA',                'AUGGCCUCUAGUUGA',
            "AUGAUGAUGAUGUAG\n",              'AUGUAG',
            'AUGCCGUACUCUAGUACUUCUCUUUUAUAA', 'AUGGGUAGUUAG'
        ],
        tests_false => [
            '', 'UGACGAUGAUUUAA', 'AUG', 'AUGGCCUAAUCUAGUUGA',
            'GCC', 'UAA', 'UAG', 'UGA', 'AUGGUGA', '12423', 'auguaa',
            'UAGAUG', 'AUGBNGHGDG', 'GBUFDBGFO', 'AUGUUUUUUUUUUUUAA',
            '  AUGUAG', 'balls of steel AUGCCGUACUCUAGUACUUCUCUUUUAUAA'
        ]
    },
);

sub run_tests {
    my ($type, $tests_ref, $rc_test) = @_;
    while (my ($number, $case) = each @$tests_ref) {
        print "$type test #$number: ";
        if ($rc_test->($case)) {
            say colored ['bold green'], 'OK';
        } else {
            say colored(['bold red'], 'FAIL'), ': "',
              $case =~ s{\n}{colored ['bold yellow'], '\n'}ger, '"';
        }
    }
    print "\n";
}

foreach my $task (@tasks) {
    say $task->{name}, "\n", '=' x length $task->{name};
    if ($task->{regex} eq qr//) {
        say 'Not implemented';
        next;
    }

    run_tests('Match', $task->{tests_true}, sub { $_[0] =~ $task->{regex} });
    run_tests('No match', $task->{tests_false}, sub { $_[0] !~ $task->{regex} });
}
continue {
    print "\n";
}
