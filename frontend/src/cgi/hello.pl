#!/usr/bin/perl
use CGI;
use Biocomp2::Middle;
$cgi = new CGI;
print $cgi->header();
my $param = $cgi->param('param');
my $x = Biocomp2::Middle::hello();
my %genes = Biocomp2::Middle::get_all_genes();
my %details = Biocomp2::Middle::get_genes();
print <<__EOF;
<html>
<head>
   <title>Hello World!</title>
</head>
<body>
<h1>Hello World! $x</h1>
__EOF
foreach my $key ( keys %genes )
{
	print "<li>key:<a href="./cgi-bin/Biocomp2/script.cgi?param=$key">$key</a> </li>,  value: $genes{$key} \n";
}
print "</body> </html>";

