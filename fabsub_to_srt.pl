#!/usr/bin/perl

use strict;
use warnings;
use utf8;
use XML::Simple;
use Data::Dumper;
use POSIX qw{strftime};

# force writing utf8 compatible output
binmode(STDOUT, ":utf8");

my $input = XMLin('fabsub.xml');

my $lineCount = 1;

foreach my $data (@{$input->{body}->{div}->{p}}) {
        print $lineCount . "\n";

        my ($beginSec, $beginMs) = split(/\./, $data->{begin});
        my ($endSec,   $endMs)   = split(/\./, $data->{end});

        print strftime("\%H:\%M:\%S,$beginMs", gmtime($beginSec));
        print " --> ";
        print strftime("\%H:\%M:\%S,$endMs", gmtime($endSec)) . "\n";

        # check if content has more than one line, which is stored as array
        if (ref $data->{"content"} eq 'ARRAY') {
            foreach my $contentLine (@{$data->{"content"}}) {
                print $contentLine . "\n";
            }
        } else {
            print $data->{content} . "\n" if ($data->{content});
        }

        print "\n";
        $lineCount++;
}
