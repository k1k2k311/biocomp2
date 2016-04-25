#!/usr/bin/env perl
#

use strict;
use warnings;

use lib '../';

use Biocomp2::Front;
use Test::More;

my $x= Biocomp2::Front::translation("ttattcacaa", "ATC");
is (1,1,"fake test");

done_testing;

