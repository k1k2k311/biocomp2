#!/usr/bin/perl
use CGI;
$cgi = new CGI;
print $cgi->header();
print <<__EOF;
<html>
<head>
   <title>Hello World!</title>
</head>
<body>
<h1>Hello World!</h1>
testing
</body>
</html>
__EOF
