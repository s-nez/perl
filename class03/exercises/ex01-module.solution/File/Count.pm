package File::Count;
use strict;
use warnings;
use autodie;

sub words {
    my ($filename) = @_;
    open my $fh, '<', $filename;

    my $count = 0;
    $count += split while <$fh>;

    close $fh;
    return $count;
}

sub lines {
    my ($filename) = @_;
    open my $fh, '<', $filename;

    readline($fh) until eof $fh;
    my $count = $.;

    close $fh;
    return $count;
}

sub chars {
    my ($filename) = @_;
    open my $fh, '<', $filename;

    my $count = 0;
    $count += length while <$fh>;

    close $fh;
    return $count;
}

1;
