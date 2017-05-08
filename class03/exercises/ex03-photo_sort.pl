#!/usr/bin/perl
use strict;
use warnings;
use autodie;
use Image::ExifTool qw[ ImageInfo ];
use File::Path qw[ make_path ];

my $dir = shift;
opendir my $dh, $dir;
while (my $file = readdir $dh) {
    my $full_path = "$dir/$file";
    next if -d $full_path;

    my $cr_date = ImageInfo("$dir/$file")->{CreateDate};
    my ($year, $month) = $cr_date =~ /\A(\d{4}):(\d{2})/;

    my $target_dir = join '/', $dir, $year, $month;
    make_path($target_dir) unless -d $target_dir;
    rename $full_path => "$target_dir/$file";
}
closedir $dh;
