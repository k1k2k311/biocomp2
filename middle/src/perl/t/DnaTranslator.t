#!/usr/bin/env perl
#

use strict;
use warnings;

use lib '../';

use Biocomp2::DnaTranslator;
use Test::More;

# should get residues / amino acids
my $HQ141567_aa = Biocomp2::DnaTranslator::translate("gcgcacgtggacgacatgcccaacgcgctgtccgccctgagcgacctgcacgcgcacaag");
is($HQ141567_aa, "AHVDDMPNALSALSDLHAHK", "simple translation");
# not multiple of 3
my $bases_5 = Biocomp2::DnaTranslator::translate("gcgca");
is($bases_5, "A", "5 dna bases");

my $complement = Biocomp2::DnaTranslator::complement("gcgcattt");
is($complement, "cgcgtaaa", 'dna complement');

my $rev_complement = Biocomp2::DnaTranslator::reverse_complement("gcgcattt");
is($rev_complement, "aaatgcgc", 'reverse dna complmement');

done_testing;

