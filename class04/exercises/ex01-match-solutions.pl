#!/usr/bin/env perl 
my $blank        = qr/\A\s*\Z/;
my $integer      = qr/\A\d+\Z/;
my $float        = qr/\A\d+(?:\.\d+)?\Z/;
my $phone_number = qr/\A\d{3}-\d{3}-\d{3}\Z/;
my $sentence     = qr/\A\w+(?:\s+\w+)*[\.?]\Z/;
my $five_l_word  = qr/\b\w{5}\b/;
my $dialog_three = qr/\A\w+:\s+(\w+)(?:\s+\g1){2,}/;
my $web_address  = qr{\A(?:https?://)?(?:www\.)?\w+(?:\.\w+)+\Z};
