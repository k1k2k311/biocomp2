#!/usr/bin/perl
use CGI		qw( escapeHTML );
use URI::Escape qw( uri_escape );
use Biocomp2::Middle;
$cgi = new CGI;
print $cgi->header();
my %genes = Biocomp2::Middle::get_genes();
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
foreach my $gene_id ( keys %genes )
{
	my $uri = 'prog1.pl?data='.uri_escape($gene_id);
   	my $html = escapeHTML($gene_id);
	my %details = %{$genes{$gene_id}};
    	my $gene_name = $details{"name"};
	my $gene_accession = $details{"accession_version"};
	my $gene_locus= $details{"locus"};
 	my $gene_product = $details{"product"};
    	my $gene_label = "$gene_name $gene_product";
	print qq{<li>Gene identifier:<tab2><a href="$uri">$html</a></tab2>, Protein product name:<tab2>$gene_name</tab2>, Genbank accession:<tab2>$gene_accession</tab2>, Location: <tab2>$gene_locus</tab2> </li> \n};

}
print "</body> </html>";

