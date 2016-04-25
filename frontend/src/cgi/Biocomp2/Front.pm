package Biocomp2::Front;
use strict;
use warnings;

sub printDetails{
	my ($uri, $html, $gene_name, $gene_product, $gene_accession, $gene_locus) =@_;
	print qq{<td><tab2><a href="$uri">$html</a></tab2></td> <td><tab2>$gene_name</tab2></td> 		<td><tab2>$gene_product</tab2></td> <td><tab2>$gene_accession</tab2></td><td><tab2>$gene_locus	    		</tab2></td> \n};
}

sub shouldHighlight{
	my ($position, $exons)= @_;
	my @exons=@{$exons};
	for my $exon_hr (@exons) {
   		my %exon = %{$exon_hr};
    		my $exon_number = $exon{'number'};
    		my $start = $exon{'start'};
    		my $end = $exon{'end'};
		if (($position>=$start) and ($position<=$end)){
			return 1;
		}
		
	}
	return 0;
}

sub translation{
	my ($coding_sequence, $aa_sequence)=@_;
	while ($coding_sequence){
		my $codon=substr($coding_sequence,0,3);
		$coding_sequence=substr($coding_sequence,3);
		my $aa_letter=substr($aa_sequence,0,1);	
		$aa_sequence=substr($aa_sequence,1);
		print qq{$codon => <tab4>$aa_letter</tab4>};
		print "&nbsp;&nbsp;";
	}
	
}





1;
