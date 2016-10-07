#!/usr/bin/env perl

use strict;
use warnings;

use FindBin;

use File::Find;
use Test::More;
use Perl::Critic;

my $critic = Perl::Critic->new(
    -profile  => '',
    -severity => 4,
);

File::Find::find(
    sub {
        my $name = $File::Find::name;
        return unless $name =~ /\.pm$/;
        my @violations = $critic->critique($name);
        is(scalar @violations, 0, "no violations in $name") or
            diag explain \@violations;
    },
    "$FindBin::Bin/../lib"
);

done_testing();