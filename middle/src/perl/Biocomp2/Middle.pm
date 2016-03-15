package Biocomp2::Middle;
use strict;
use warnings;
use Biocomp2::DataAccess;

sub hello {
  my $ggg = Biocomp2::DataAccess::bye();
  return "testing6666  $ggg";
}

sub get_all_genes {
  my %gene_names = Biocomp2::DataAccess::get_gene_names();
  return %gene_names;
}

sub get_genes {
	my %genes = Biocomp2::DataAccess::get_genes();
	return %genes;
}

1;
