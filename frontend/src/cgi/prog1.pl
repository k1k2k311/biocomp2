#!/usr/bin/perl
use CGI		qw( escapeHTML );
use URI::Escape qw( uri_escape );
use Biocomp2::Middle;
my $query = new CGI;print $query->header();my $gene_id = $query->param('data');
my %details = Biocomp2::Middle::get_gene_details($gene_id);
print <<__EOF;
<html>
<head>
<style>
body {background-color:white;}
h1   {color:black; text-align: center;}
tab1 {padding: 40px; color:black;}
tab2 {color:grey;}
</style>
   <title>Chromosome 16</title>
</head>
<body>
<h1>Chromosome 16</h1>
__EOF
	my $gene_name = $details{"name"};
	my $gene_accession = $details{"accession_version"};
	my $gene_locus= $details{"locus"};
 	my $gene_product = $details{"product"};
    	my $gene_label = "$gene_name $gene_product";
	print qq{<li>Gene identifier:<tab2>$gene_id</tab2>, Protein product name:<tab2>$gene_name</tab2>, 
	Genbank accession:<tab2>$gene_accession</tab2>, Location: <tab2>$gene_locus</tab2> </li> \n};
	print "</body> </html>";

