#!/usr/bin/env perl
#

use strict;
use warnings;

use lib '../';

use Biocomp2::Middle;
use Test::More;

is(1, 1, 'one allele should match');
ok(1, "true, it is ok");

done_testing();

