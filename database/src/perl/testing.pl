#!/usr/bin/perl
use CGI;
use Biocomp2::DataAccess;

my %genes= Biocomp2::DataAccess::get_genes();

foreach my $key (keys %genes)
{
	#print "key $key value $genes{$key} \n";
	#print "key $key value1 @{ $genes{$key} } \n"
	my $locus = @{ $genes{$key} }[1];
	my $acc_ver = @{ $genes{$key} }[0];
	print $locus, "\n";  
	print $acc_ver, "\n";  

}


