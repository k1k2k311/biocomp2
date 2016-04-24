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
  my $coding_sequence = $details{'coding_sequence'};
  if (! defined $coding_sequence) {
    $coding_sequence = "undefined";
  }
  print "  coding sequence  : $coding_sequence\n";

  my $aa_sequence = $details{'aa_sequence'};
  print "  aa sequence      : $aa_sequence\n";
  
  # determine best frameshift match
  my %frame_residues = Biocomp2::DnaTranslator::translate_all_frames($coding_sequence);
  my %frame_scores;
  my $high_score = 0;
  my $best_frameshift;
  for my $offset (keys %frame_residues) {
    print "    offset: $offset\n";
    my $offset_aa_sequence = $frame_residues{$offset};
    print "      aa_sequence: $offset_aa_sequence\n";
    my $frame_score = score($aa_sequence, $offset_aa_sequence);
    if ($frame_score > $high_score) {
      $high_score = $frame_score;
      $best_frameshift = $offset;
    }
    print "      score: $frame_score\n";
  }
  print "    best frameshift: $best_frameshift\n";
  
  print "    length: ".length($aa_sequence)."\n";
  # TODO
  # enzyme cutting
  # codon frequencyd
}

sub score {
  my ($aa_sequence, $offset_aa_sequence) = @_;
  # score naively using best substring overlap
  my $aa_sequence_length = length $aa_sequence;
  # best substr length
  my $best = 0;
  for my $i (0..$aa_sequence_length) {
#    print "$i\n";
    my $max_substr_length = $aa_sequence_length - $i;
    for my $substr_length (($best+1)..$max_substr_length) {
      my $candidate = substr $aa_sequence, $i, $substr_length;
#      print "$candidate\n";
	
      # matched
      if (-1 != index $offset_aa_sequence, $candidate) {
        $best = $substr_length;
      }
      else {
        last;
      }
    }
  }
  
  return $best;
}
