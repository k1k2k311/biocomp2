#!/usr/bin/perl
use CGI		qw( escapeHTML );
use URI::Escape qw( uri_escape );
use Biocomp2::Middle;
$cgi = new CGI;
print $cgi->header();
my %genes = Biocomp2::Middle::get_all_genes();
my %details = Biocomp2::Middle::get_genes();
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
foreach my $key ( keys %genes )
{
	my $uri = 'prog1.pl?data='.uri_escape($key);
   	my $html = escapeHTML($key);
	print qq{<li>Gene identifier:<tab2><a href="$uri">$html</a></tab2>, Protein product name:<tab2>$genes{$key}</tab2></li> \n};

}
print "</body> </html>";

