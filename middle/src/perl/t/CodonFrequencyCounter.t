#!/usr/bin/env perl
#

use strict;
use warnings;

use lib '../';

use Biocomp2::CodonFrequencyCounter;
use Test::More;

my %aaa1 = Biocomp2::CodonFrequencyCounter::get_frequencies("AAA");
my $aaa1_count = keys %aaa1;
is($aaa1_count, 1, 'should have one result');
is($aaa1{'AAA'}, 1, 'AAA should be result with a count of one');

done_testing;

