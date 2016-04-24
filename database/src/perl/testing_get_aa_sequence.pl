#!/usr/bin/perl
use CGI;
use Biocomp2::DataAccess;

my $aminoacid= Biocomp2::DataAccess::get_aa_sequence(1869775);


print "AA_Sequence:		\n", $aminoacid, "\n\n";


