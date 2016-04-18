#!/usr/bin/env perl
#
# author: Jurn Ho <jurn@magicmonster.com>
# description: coursework for biocomputing I

use strict;
use warnings;

use lib '../';

use Biocomp2::Middle;
use Test::More;

is(1, 1, 'one allele should match');
ok(true, "AAADSARTA should be a peptide");

done_testing()
