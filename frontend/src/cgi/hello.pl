#!/usr/bin/perl
use CGI;
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
tab1 {padding: 10px; color:black;}
tab2 {color:grey;}
</style>
   <title>Hello World!</title>
</head>
<body>
<h1>Hello World! $x</h1>
__EOF
foreach my $key ( keys %genes )
{
	print "<li>key:<tab2>$key</tab2>,  <tab1>value:</tab1><tab2> $genes{$key} </tab2></li> \n";
}
print "</body> </html>";

