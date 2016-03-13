#!/usr/bin/perl
use strict;
use warnings;
use DBI;



my $file = 'chrom_CDS_16';


# Initialise variables
#my ( @acc_version)
my $locus = '';
my $version = '';
my $accession = '';
my $accession_version = '';
my $gene_ID = '';


my @genebank = file_to_array($file);


for 







####################################################################			
########### Subroutines
####################################################################
#
#
#

##################################		
########### file_to_array ########
##################################

sub file_to_array {

	# get file name and initialise variable
	my ($fin_name) = @_;
	my @fin =();
	open (DATA, $fin_name) or die "\nCan't open fin_name, closing!!! \n";

	@fin = <DATA>;
	
	close DATA;
	return @fin;
}

##################################		
####### split_genebank  ##########
##################################


sub split_genebank  {

	my($fh) = @_;
	
	my($entry) = '';
	my($reset_separator) = $/;
	
	$/ = "//\n";
	
	$entry = <$fh>;
	$/ = $reset_separator;
	return $entry;
}




##################################		
########### parse_to_hash ########
##################################







1;
exit;
