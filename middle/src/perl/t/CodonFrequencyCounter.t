#!/usr/bin/env perl
#

use strict;
use warnings;

use lib '../';

use Biocomp2::CodonFrequencyCounter;
use Test::More;

my %aaa1 = Biocomp2::CodonFrequencyCounter::get_frequencies("aaa");
my $aaa1_count = keys %aaa1;
is($aaa1_count, 64, 'should have 64 results');
is($aaa1{'aaa'}, 1, 'aaa should be result with a count of one');

done_testing;

