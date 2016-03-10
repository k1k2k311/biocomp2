package Biocomp2::Middle;
use strict;
use warnings;
use Biocomp2::DataAccess;

sub hello {
  my $ggg = Biocomp2::DataAccess::bye();
  return "testing6666  $ggg";
}

sub get_all_genes {
  my %all_genes;
  $all_genes{'60391390'}='MTG16';
  $all_genes{'3550832'}='TSC2';
  return %all_genes;
}

1;