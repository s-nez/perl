#!/usr/bin/env perl 
use strict;
use warnings;
use autodie;
use Data::Dumper;
use v5.18;

die "You need to provide a filename\n" unless @ARGV >= 1;
my ($filename, $no_of_questions) = @ARGV;
$no_of_questions //= 3;

my @questions;
open my $QUIZ_DATA, '<', $filename;
until (eof $QUIZ_DATA) {
    my %data;
    (undef, $data{Question}) = split ': ', <$QUIZ_DATA>;

    my @answers;
    push @answers, scalar <$QUIZ_DATA> for (1 .. 4);
    $data{Answers} = \@answers;

    (undef, $data{Correct}) = split ' = ', <$QUIZ_DATA>;
    push @questions, \%data;

    <$QUIZ_DATA>; # skip the empty line
}
close $QUIZ_DATA;
die "Not enough questions\n" if $no_of_questions > @questions;

my %selected;
while (keys %selected < $no_of_questions) {
    undef $selected{int rand @questions};
}

my $score = 0;
foreach my $question_id (keys %selected) {
    say $questions[$question_id]{Question};
    print foreach @{ $questions[$question_id]{Answers} };

    print "Odpowiedź: ";
    my $ans = <STDIN>;

    if (uc $ans eq $questions[$question_id]{Correct}) {
        say 'Poprawna odpowiedź!';
        ++$score;
    } else {
        say 'Błędna odpowiedź';
    }
    print "\n";
}
say "Twój wynik: $score/$no_of_questions";
