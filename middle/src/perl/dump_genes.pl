#!/usr/bin/perl

use strict;
use warnings;

use Biocomp2::Middle;
use Biocomp2::DnaTranslator;

my %genes = Biocomp2::Middle::get_genes();
foreach my $gene_id ( keys %genes )
{
  print "gene_id: $gene_id\n";
  dump_details($gene_id);
}

sub dump_details {
  my ($gene_id) = @_;
  my %details = Biocomp2::Middle::get_gene_details($gene_id);
  my $accession_version = $details{'accession_version'};
  print "  accession_version: $accession_version\n";
  my $dna_sequence = $details{'dna_sequence'};
  print "  dna sequence     : $dna_sequence\n";
  print "  dna sequence len : ".length($dna_sequence)."\n";
  my $exons = $details{'exons'};
  my @exons = @{$exons};
#  print "  exons: $exons\n";
  my $exon_total_length = 0;
  for my $exon_hr (@exons) {
    my %exon = %{$exon_hr};
    my $exon_number = $exon{'number'};
    my $start = $exon{'start'};
    my $end = $exon{'end'};
    print "    exon $exon_number from $start to $end\n";
    my $exon_length = $end-$start+1;
    $exon_total_length = $exon_total_length + $exon_length;
    print "      length: $exon_length\n";
  }
  print "    exon total length: $exon_total_length\n";  
  my $coding_sequence_db = $details{'coding_sequence_db'};
  if (! defined $coding_sequence_db) {
    $coding_sequence_db = "undefined";
  }
  print "  coding sequence db: $coding_sequence_db\n";

  my $aa_sequence_db = $details{'aa_sequence_db'};
  print "  aa sequence db    : $aa_sequence_db\n";
  
  my $aa_sequence = $details{'aa_sequence'};
  print "  aa sequence       : $aa_sequence\n";
  
  my $coding_sequence = $details{'coding_sequence'};
  print "  coding sequence   : $coding_sequence\n";
  
  my %codon_frequencies = %{$details{'codon_frequencies'}};
  print "  codon frequencies:\n";
  for my $codon (sort keys %codon_frequencies) {
    my $codon_frequency = $codon_frequencies{$codon};
    print "    $codon: $codon_frequency\n";
  }
  print %codon_frequencies;
  # TODO
  # enzyme cutting
  # codon frequencyd
}


