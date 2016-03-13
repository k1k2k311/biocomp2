#!/usr/bin/perl
use strict;
use warnings;
use DBI;


my $file = 'chrom_CDS_16';

# Initialise variables
#my ( @acc_version)
my $locus = '';


my @genebank = file_to_array($file);

for my $gb_line (@genebank) {

	if($gb_line =~ /^LOCUS/) {
		$gb_line =~ s/^LOCUS\s*//;
		$locus = $gb_line;
		print $locus;
	}
	



}




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



1;
exit;
