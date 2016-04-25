#!/usr/bin/perl
use CGI		qw( escapeHTML );
use CGI::Carp qw/fatalsToBrowser/;
use URI::Escape qw( uri_escape );
use Biocomp2::Middle;
use Biocomp2::Front;
$query = new CGI;
print $query->header();
# the gene_id variable is what the user pressed to view details
my $gene_id = $query->param('data');
# getting results from middle layer's subroutine 
my %details = Biocomp2::Middle::get_gene_details($gene_id);

print <<__EOF;
<html>
<head>
<link rel="stylesheet" type="text/css" href="http://student.cryst.bbk.ac.uk/~ea001/style.css">
<title>Chromosome 16</title>
</head>
<body>
<h1>Chromosome 16</h1>
<tab3><form method="GET" action="search.pl">
<input type="text" name="search" placeholder="Search the database">
<input type="submit" value="Search"></form></tab3>

__EOF

print "<table>\n";
# print out the result we got from the subroutine
print "<thead>    <tr><td>Gene identifier</td><td>Gene name</td><td>Protein product name</td><td>Genbank accession</td><td>Location</td></tr>";
	my $gene_name = $details{"name"};
	my $gene_product = $details{"product"};
	my $gene_accession = $details{"accession_version"};
	my $gene_locus= $details{"locus"};
	my $dna_seq= $details{"dna_sequence"};
	my $aa_sequence = $details{'aa_sequence'};
	my $coding_sequence = $details{'coding_sequence'};
	my $length=length($dna_seq);
	my $i=0;
	my $j=$length;
	my $exons = $details{'exons'};
  	my @exons = @{$exons};
	my $exon_number = $exon{'number'};
	print " <tr>\n";
	print qq{<td><tab2>$gene_id</tab2></td> <td><tab2>$gene_name</tab2></td><td><tab2>$gene_product	</tab2></td> <td><tab2>$gene_accession</tab2></td><td><tab2>$gene_locus</tab2></td> \n};
	print " </tr>\n";
	print "</thead>";
	print "</table>\n";
	
	my @array_seq;	  	while($dna_seq) {
		my $base=chop($dna_seq);   		push (@{$array_seq[$j]}, $base);
		my $color= Biocomp2::Front::shouldHighlight($j,\@exons);
		push (@{$array_seq[$j]}, $color);	
		$j=$j-1;  		}	
	my $counter=0;

	print qq{<h2>Complete DNA sequence with the coding regions</h2>};
	foreach my $element( @array_seq)
	{	
		my @base_and_highlight=@{$element};
		my ($base, $highlight)=@base_and_highlight;
		if ($highlight==1){
			print qq{<mark>$base</mark>};
		}
		else{
			print $base;
		}
		$counter++;
		if ($counter%100==0){
			print "<br/>";
		}
	}

	print "<br/>";print "<br/>";
	 for my $exon_hr (@exons) {
    		my %exon = %{$exon_hr};
    		my $exon_number = $exon{'number'};
    		my $start = $exon{'start'};
    		my $end = $exon{'end'};
    		print qq{Exon <tab4>$exon_number</tab4> starts at position <tab4>$start</tab4> and ends at 			position <tab4>$end</tab4> <br/>};
   		
 	}

	print qq{<h2>The amino acid sequence displayed with the coding DNA sequence</h2>};
	Biocomp2::Front::translation($coding_sequence, $aa_sequence);
	print qq{<h2>Codon usage frequencies within the coding region</h2>};
	print "<table><tr>";
	my $counter=0;
	my %codon_frequencies = %{$details{'codon_frequencies'}};
  	for my $codon (sort keys %codon_frequencies) {
    		my $codon_frequency = $codon_frequencies{$codon};
		print qq{<td>$codon=>$codon_frequency</td>};
		$counter++;
		if ($counter==16){	
			$counter=0;
			print "<tr/><tr>";
		}	
    	}
	
		
	
	print "</tr></table>";
	print "</body> </html>";
