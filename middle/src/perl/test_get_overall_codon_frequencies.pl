#!/usr/bin/perl

use strict;
use warnings;

use Biocomp2::Middle;

my %frequencies = Biocomp2::Middle::get_overall_codon_frequencies();
for my $codon (sort keys %frequencies) {
  my $frequency = $frequencies{$codon};
  print "$codon: $frequency\n";
}
