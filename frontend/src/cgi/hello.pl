#!/usr/bin/perl
use CGI		qw( escapeHTML );
use URI::Escape qw( uri_escape );
use Biocomp2::Middle;
$cgi = new CGI;
print $cgi->header();
my $x = Biocomp2::Middle::hello();
my %genes = Biocomp2::Middle::get_all_genes();
my %details = Biocomp2::Middle::get_genes();
print <<__EOF;
<html>
<head>
<style>
body {background-color:white;}
h1   {color:blue;}
tab1 {padding: 30px; color:black;}
tab2 {color:grey;}
</style>
   <title>Hello World!</title>
</head>
<body>
<h1>Hello World! $x</h1>
__EOF
foreach my $key ( keys %genes )
{
	my $uri = 'prog1.cgi?data='.uri_escape($key);
   	my $html = escapeHTML($key);
   	print qq{<a href="$uri">$html</a>};
}
print "</body> </html>";

