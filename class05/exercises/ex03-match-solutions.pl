#!/usr/bin/env perl 
my $nostart_comment = qr{(?<!\A)(\#|//)};
my $not_evil_nums   = qr/\A\d{6,}(?<!666\Z)/;
my $read_frame      = qr/\AAUG(?:(?!UAG|UGA|UAA)[AUCG]{3})*(?:UAG|UGA|UAA)\Z/;
