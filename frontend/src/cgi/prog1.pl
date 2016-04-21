#!/usr/bin/perl
use CGI		qw( escapeHTML );
use URI::Escape qw( uri_escape );
use Biocomp2::Middle;
my $query = new CGI;print $query->header();
# the gene_id variable is what the user pressed to view detailsmy $gene_id = $query->param('data');
# getting results from middle layer's subroutine 
my %details = Biocomp2::Middle::get_gene_details($gene_id);
print <<__EOF;
<html>
<head><link rel="stylesheet" type="text/css" href="http://student.cryst.bbk.ac.uk/~ea001/style.css">
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
print "<thead>    <tr><td>Gene identifier</td><td>Protein product name</td><td>Genbank accession</td><td>Location</td></tr>";
	my $gene_name = $details{"name"};
	my $gene_accession = $details{"accession_version"};
	my $gene_locus= $details{"locus"};
	print "  <tr>\n";
	print qq{<td><tab2>$gene_id</tab2></td> <td><tab2>$gene_name</tab2></td> <td><tab2>$gene_accession</tab2></td><td><tab2>$gene_locus</tab2></td> \n};
	print " </tr>\n";
print "</thead>";print "</table>\n";
print "</body> </html>";
