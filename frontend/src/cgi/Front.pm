package Biocomp2::Front;
use strict;
use warnings;

sub printDetails{
	my ($uri, $html, $gene_name, $gene_product, $gene_accession, $gene_locus) =@_;
	print qq{<td><tab2><a href="$uri">$html</a></tab2></td> <td><tab2>$gene_name</tab2></td> 		<td><tab2>$gene_product</tab2></td> <td><tab2>$gene_accession</tab2></td><td><tab2>$gene_locus	    		</tab2></td> \n};
}

1;
