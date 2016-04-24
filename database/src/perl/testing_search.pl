#!/usr/bin/perl
use CGI;
use Biocomp2::DataAccess;

my %gene_details= Biocomp2::DataAccess::get_search('receptor');


foreach my $key (keys %gene_details)
{
	my $gene_ID = $key;
	my @values = @{$gene_details{$key}};
	print $gene_ID;
	print Dumper \@values;

	for my $i ( 0 .. $#values ) {

    	print "element @values[$i] \n";
         
    }

	
}	

