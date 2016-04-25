package Biocomp2::Middle;
use strict;
use warnings;
use Biocomp2::DataAccess;
use Biocomp2::CodonFrequencyCounter;
use Biocomp2::CodonFrequencies;
use Biocomp2::RestrictionEnzyme;
use Biocomp2::DnaTranslator;

# returns same data structure as get_genes()
sub search {
  my ($query) =  @_;
  my %genes_db = Biocomp2::DataAccess::get_search($query);
  # convert from hash of arrays to hash of hashes
  my %genes;
  for my $gene_id (keys %genes_db) {
#    print "$gene_id\n";
    # deref
    my @genes_db_array = @{$genes_db{$gene_id}};
    # make a new hash for the gene details
    my %gene_details;
    my $accession_version = $genes_db_array[0];
    my $gene_name = $genes_db_array[1];
    my $gene_locus =  $genes_db_array[2];
    my $product = $genes_db_array[3];
    my $protein_id = $genes_db_array[4];
    $gene_details{"accession_version"} = $accession_version;
    $gene_details{"name"} = $gene_name;
    $gene_details{"locus"} = $gene_locus;
    $gene_details{"product"} = $product;
    $gene_details{"protein_id"} = $protein_id;
    $genes{$gene_id} = \%gene_details;
  }
  return %genes;
}

sub get_genes {
  my %genes_db = Biocomp2::DataAccess::get_genes();
  # convert from hash of arrays to hash of hashes
  my %genes;
  for my $gene_id (keys %genes_db) {
#    print "$gene_id\n";
    # deref
    my @genes_db_array = @{$genes_db{$gene_id}};
    # make a new hash for the gene details
    my %gene_details;
    my $accession_version = $genes_db_array[0];
    my $gene_name = $genes_db_array[1];
    my $gene_locus =  $genes_db_array[2];
    my $product = $genes_db_array[3];
    my $protein_id = $genes_db_array[4];
    $gene_details{"accession_version"} = $accession_version;
    $gene_details{"name"} = $gene_name;
    $gene_details{"locus"} = $gene_locus;
    $gene_details{"product"} = $product;
    $gene_details{"protein_id"} = $protein_id;
    $genes{$gene_id} = \%gene_details;
  }
  return %genes;
}

sub get_gene_details {
  # input: gene ID
  my ($gene_id) = @_;

  my $db_gene_details_hash_ref = Biocomp2::DataAccess::get_gene_details($gene_id);
  my %db_gene_details = %$db_gene_details_hash_ref;

  my %gene_details;
  # copy specific fields from dao layer.
  $gene_details{'id'} = $gene_id;
  $gene_details{'accession_version'} = $db_gene_details{'acc_ver'};
  $gene_details{'name'} = $db_gene_details{'gene'};
  $gene_details{'locus'} = $db_gene_details{'map'};
  $gene_details{'product'} = $db_gene_details{'product'};
  $gene_details{'protein_id'} = $db_gene_details{'protID'};
  # get sequence
  my $sequence = Biocomp2::DataAccess::get_sequence($gene_id);
  $gene_details{'dna_sequence'} = $sequence;
  
  my @coordinates = Biocomp2::DataAccess::get_coordinates($gene_id);
  my @exons;
  my $coding_sequence;
  foreach my $co_ar (@coordinates) {
    my @a = @{$co_ar};
#    my $exon_number = $a[0];
    my $start = $a[1];
    my $end = $a[2];
    my %exon;
    $exon{'number'} = $a[0];
    $exon{'start'} = $a[1];
    $exon{'end'} = $a[2];
    push @exons, \%exon;
    my $exon_sequence = substr($sequence, $start, $end-$start+1);
    $coding_sequence = $coding_sequence.$exon_sequence;
  }
  $gene_details{'exons'} = \@exons;
  
  $gene_details{'coding_sequence_db'} = $coding_sequence;
  my $aa_sequence = Biocomp2::DataAccess::get_aa_sequence($gene_id);
  $gene_details{'aa_sequence_db'} = $aa_sequence;
  
  # get best matching
  # determine best frameshift match
  my %frame_residues = Biocomp2::DnaTranslator::translate_all_frames($coding_sequence);
  my %frame_scores;
  my $high_score = 0;
  my $best_frameshift;
  for my $frameshift (keys %frame_residues) {
    my $offset_aa_sequence = $frame_residues{$frameshift};
    my $frame_score = score($aa_sequence, $offset_aa_sequence);
    if ($frame_score > $high_score) {
      $high_score = $frame_score;
      $best_frameshift = $frameshift;
    }
  }
  my $best_coding_sequence = Biocomp2::DnaTranslator::frameshift($coding_sequence, $best_frameshift);
  my $best_aa_sequence = Biocomp2::DnaTranslator::translate($best_coding_sequence);
  $gene_details{'coding_sequence'} = $best_coding_sequence;
  $gene_details{'aa_sequence'} = $best_aa_sequence;
  $gene_details{'frameshift'} = $best_frameshift;
  
  my %codon_frequencies = Biocomp2::CodonFrequencyCounter::get_frequencies($best_coding_sequence);
  $gene_details{'codon_frequencies'} = \%codon_frequencies;
  
  my %restriction_sites = Biocomp2::RestrictionEnzyme::get_all_restriction_enzyme_sites($best_coding_sequence, \@exons);
  $gene_details{'restriction_sites'} = \%restriction_sites;
  return %gene_details;

}

sub get_overall_codon_frequencies {
  return Biocomp2::CodonFrequencies::get_overall_codon_frequencies();
}

sub calculate_custom_restriction_enzyme_sites {
  my ($gene_id, $enzyme_pattern) = @_;
  # lookup gene dna sequence
  my $sequence = Biocomp2::DataAccess::get_sequence($gene_id);
  return Biocomp2::RestrictionEnzyme::get_enzyme_sites($sequence, $enzyme_pattern);
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


1;
