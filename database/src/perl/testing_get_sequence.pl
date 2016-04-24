#!/usr/bin/perl
use CGI;
use Biocomp2::DataAccess;

my $sequence= Biocomp2::DataAccess::get_sequence(1869775);


print "Sequence:		\n", $sequence, "\n\n";


