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

my %frame_translations = Biocomp2::DnaTranslator::translate_all_frames("gcgcacgtggacgacatgcccaacgcgctgtccgccctgagcgacctgcacgcgcacaag");
# print %frame_translations;
is($frame_translations{'P0'}, 'AHVDDMPNALSALSDLHAHK', 'frame translate: positive strand offset 0');
is($frame_translations{'P1'}, 'RTWTTCPTRCPP-ATCTRT', 'frame translate: positive strand offset 1');
is($frame_translations{'P2'}, 'ARGRHAQRAVRPERPARAQ', 'frame translate: positive strand offset 2');
is($frame_translations{'N0'}, 'LVRVQVAQGGQRVGHVVHVR', 'frame translate: negative strand offset 0');
is($frame_translations{'N1'}, 'LCACRSLRADSALGMSSTC', 'frame translate: negative strand offset 1');
is($frame_translations{'N2'}, 'CARAGRSGRTARWACRPRA', 'frame translate: negative strand offset 2');

my $shift_negative2 = Biocomp2::DnaTranslator::frameshift('gcgcact','N2');
is($shift_negative2, 'tgc', 'frame shift N2');
done_testing;

