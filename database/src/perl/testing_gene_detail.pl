#!/usr/bin/perl
use CGI;
use Biocomp2::DataAccess;

#my @gene_details= Biocomp2::DataAccess::get_gene_details();

#foreach my $element (@gene_deails) {
#
#	print $element, "\n";
#}

my $gene_details_ref= Biocomp2::DataAccess::get_gene_details(517348);
my %gene_details = %$gene_details_ref;

foreach my $key (keys %gene_details)
{
	my $gene_ID = $key;
	my $value = $gene_details{$key};
	print "KEY			", $key, "\n"; 
	print "Value			", $value, "\n";
	
}	
