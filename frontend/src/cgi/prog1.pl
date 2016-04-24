#!/usr/bin/perl
use CGI		qw( escapeHTML );
use CGI::Carp qw/fatalsToBrowser/;
use URI::Escape qw( uri_escape );
use Biocomp2::Middle;
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
print "<thead>    <tr><td>Gene identifier</td><td>Protein product name</td><td>Genbank accession</td><td>Location</td></tr>";
	my $gene_name = $details{"name"};
	my $gene_accession = $details{"accession_version"};
	my $gene_locus= $details{"locus"};
	my $dna_seq= $details{"dna_sequence"};
	my $length=length($dna_seq);
	my $i=0;
	my $j=$length;
	my $dna_seq2=$dna_seq;
	my @array_subseq;

	
	print "  <tr>\n";
	print qq{<td><tab2>$gene_id</tab2></td> <td><tab2>$gene_name</tab2></td> <td><tab2>$gene_accession</tab2></td><td><tab2>$gene_locus</tab2></td> \n\n\n};
	print " </tr>\n";
	
	my @array_seq;	  		while($dna_seq2) {
			my $base=chop($dna_seq2);   			push (@{$array_seq[$j]}, $base);
			my $array=$array_seq[$j][0];
			print $array;	
			$j=$j-1;  		}	
	
	while ($i<=$length){
		my $chopped= substr($dna_seq,$i,100);
		push @array_subseq, $chopped;
		$i=$i+100;
	}
	
	foreach my $element( @array_subseq)
	{	
		print "<tr><td>";
		print $element;
		print "</td></tr>";
	}

	
print "</thead>";
print "</table>\n";
print "</body> </html>";
