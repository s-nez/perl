#!/usr/bin/env perl 
use strict;
use warnings;
use v5.18;

###########################################
# Tests - do not touch, there be monsters #
###########################################
my @tasks = (
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
    }
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
