#!/usr/bin/perl
use CGI;
use Biocomp2::DataAccess;

my %genes= Biocomp2::DataAccess::get_genes();

foreach my $key (keys %genes)
{
	#($acc_ver, $gene, $map, $product, $protID)
	my $gene_ID = $key;
	my $acc_ver = @{ $genes{$key} }[0];
	my $gene = @{ $genes{$key} }[1];
	my $map = @{ $genes{$key} }[2];
	my $product = @{ $genes{$key} }[3];
	my $protID = @{ $genes{$key} }[4];
	
	print "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n";
	print "Gene ID			", $gene_ID, "\n";  
	print "Accesion Version	", $acc_ver, "\n"; 
	print "Locus Map		", $map, "\n";
	print "Product			", $product, "\n";
	print "Protein ID		", $protID, "\n"; 

}


