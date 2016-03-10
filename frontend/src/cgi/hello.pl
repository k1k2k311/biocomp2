#!/usr/bin/perl
use CGI;
use Biocomp2::Middle;
$cgi = new CGI;
print $cgi->header();
my $x = Biocomp2::Middle::hello();
print <<__EOF;
<html>
<head>
   <title>Hello World!</title>
</head>
<body>
<h1>Hello World! $x</h1>
testing
</body>
</html>
__EOF
