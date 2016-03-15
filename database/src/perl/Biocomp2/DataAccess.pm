package Biocomp2::DataAccess;
use strict;
use warnings;

sub bye {
  return "validating 44444";
}

sub get_gene_names {
	my %gene_names;
	#SELECT gene_ID, acc_ver  FROM chromosome16_genes;
	## EXAMPLE ## $gene_names{'$gene_ID'}='$acc_ver'
	return %gene_names;
	print "Its working";

}

1; 

