#!/usr/bin/perl

use strict;
use warnings;

use Biocomp2::Middle;
use Biocomp2::DnaTranslator;

my %genes = Biocomp2::Middle::get_genes();
my %overall_codon_frequencies;
foreach my $gene_id ( keys %genes )
{
#  print "gene_id: $gene_id\n";
  my %details = Biocomp2::Middle::get_gene_details($gene_id);
  my %codon_frequencies = %{$details{'codon_frequencies'}};
  for my $codon (sort keys %codon_frequencies) {
    if (! exists $overall_codon_frequencies{$codon}) {
      # init
      $overall_codon_frequencies{$codon} = 0;
    }
    my $codon_frequency = $codon_frequencies{$codon};
    # add
    $overall_codon_frequencies{$codon} = $overall_codon_frequencies{$codon} + $codon_frequency;
  }
}
print "overall coding frequencies\n";
for my $codon (sort keys %overall_codon_frequencies) {
  my $codon_frequency = $overall_codon_frequencies{$codon};
  print "$codon,$codon_frequency\n";
}
