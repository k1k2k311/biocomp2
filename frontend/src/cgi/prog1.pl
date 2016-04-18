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
h1 {    color: #f7f7f7;
    text-align: center;    font-size: 50px;    font-weight: bold;    background-image: url(//static.pubmed.gov/portal/portal3rc.fcgi/4082620/img/32161);    margin: 0;    padding: 33px 75px 33px 75px;    line-height: 1px;}
tab1 {padding: 40px; color:black;}
tab2 {color:grey;}
tab3 {text-align:right;}</style>
<title>Chromosome 16</title>
</head>
<body>
<h1>Chromosome 16</h1>
<tab3><form method="GET" action="/search">
<input type="text" name="search" placeholder="Search the database">
<input type="submit" value="Search"></form></tab3>

__EOF

print "<table>\n";
print "<thead>    <tr><td>Gene identifier</td><td>Protein product name</td><td>Genbank accession</td><td>Location</td></tr>";
	my $gene_name = $details{"name"};
	my $gene_accession = $details{"accession_version"};
	my $gene_locus= $details{"locus"};
 	my $gene_product = $details{"product"};
    	my $gene_label = "$gene_name $gene_product";
	print "  <tr>\n";
	print qq{<td><tab2>$gene_id</tab2></td> <td><tab2>$gene_name</tab2></td> <td><tab2>$gene_accession</tab2></td><td><tab2>$gene_locus</tab2></td> \n};
	print " </tr>\n";
print "</thead>";print "</table>\n";
print "</body> </html>";
