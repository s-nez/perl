package Record;
use strict;
use warnings;

sub set {
    my ($array_ref, $params) = @_;
    foreach my $record (@$array_ref) {
        @$record{ keys %$params } = values %$params;
    }
    return;
}

sub default {
    my ($array_ref, $params) = @_;
    foreach my $record (@$array_ref) {
        while (my ($key, $val) = each %$params) {
            $record{$key} //= $val;
        }
    }
    return;
}

sub move {
    my ($array_ref, $params) = @_;
    foreach my $record (@$array_ref) {
        while (my ($from, $to) = each %$params) {
            $record{$to} = delete $record{$from} if exists $record{$from};
        }
    }
    return;
}

sub copy {
    my ($array_ref, $params) = @_;
    foreach my $record (@$array_ref) {
        while (my ($from, $to) = each %$params) {
            $record{$to} = $record{$from} if exists $record{$from};
        }
    }
    return;
}

1;
