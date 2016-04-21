#!/usr/bin/perl

use strict;
use warnings;

use Biocomp2::Middle;

my %genes = Biocomp2::Middle::search("receptor");
foreach my $gene_id ( keys %genes )
{
  print "gene_id: $gene_id, value: $genes{$gene_id}\n";
  my %details = %{$genes{$gene_id}};
  my $gene_name = $details{"name"};
  my $gene_product = $details{"product"};
  print "gene name: $gene_name\n";
  print "gene product: $gene_product\n";
}
