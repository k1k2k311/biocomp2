package Biocomp2::Middle;
use strict;
use warnings;
use Biocomp2::DataAccess;

sub hello {
  return "do not use";
}


sub get_all_genes {
  my %gene_names = Biocomp2::DataAccess::get_gene_names();
  return %gene_names;
}

# { 
#    gene_id: {
#       accession_version: ..
#    }
# }
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

# You must be able to search the database to find an entry based on gene identifier,
# protein product names, Genbank accession, or chromosomal location.
sub search {
  # input: single search field e.g. "N-acetylgalactosamine 6-sulphatase"
  # is it case sensitive. NO
  # substring search should work e.g. "acetyl"
  # @search_results_gene_ids = Biocomp2::DataAccess::search(search_string)
  # loop through each of the gen_ids:
  #     Biocomp2::DataAccess::get_gene_details(gene_id)
  # output: array of above
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

  # Biocomp2::DataAccess::get_gene_sequences(gene_id)
  # hash {
#      dna_sequence: "AGAGATAGAGCCC",
#      frame_offset: 1 2 or 3,
#      aa_sequence: "MAJKLSFKJLASF"
#    }

  # Biocomp2::DataAccess::get_gene_coordinates(gene_id)
  # [[30,60],[77,99]]

  # copy above to gene details
  # calculate codon frequencies
  # calculate cloning cutting offsets

  # output: hash
  # {
#      name: "",
#      protein_name: "",
#      locus: ""
#      dna_sequence: "agcgcgacggccatgcgatactac",
#      aa_sequence: "MAJKLSFKJLASF"
#      coding_regions: [
#                [30,60],
#                [77,90],
#                [200,300]
#                ],
#      codon_frequences: {
#         AAA: 3,
#         ATG: 8,
#         CCC: 3
#      },
#      cloning: {
#        enzyme: [start, cut, end]
#      },
#      cloning: {
#        "BAMH1": [15, 17, 21],
#        "ZZZZZ": [14, 15, 20],
#        "XXXXX": [320, 328, 330]
#      }
  # }
  #

}

#sub overall_codon_frequences{
#   hash {
#         AAA: 3,
#         ATG: 8,
#         CCC: 3
#      }
#}

# restriction enzymes
#   degenerate
# AC^GGTGGA sequence
# ^ is where it will cut
# this is the equivalent of
# TCCACC^GT
# do not use if it cuts in exon or intron (between 5' and 3' do not use)

#  plasmid is circular DNA that will help create proteins,
# e.g. open ring, ligate the insert.
# if we use the same enzyme, sticky ends will have the same dna, so might get included reversed.



1;
