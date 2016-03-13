#!/usr/bin/perl
use strict;
use warnings;
use DBI;

#my $cmd = 'wget http://www.bioinf.org.uk/teaching/bbk/biocomp2/data/chrom_CDS_16.gz';
#system($cmd);

my $cmd = 'gunzip chrom_CDS_16.gz';
system($cmd);


# Open data file 
my $data_file = "chrom_CDS_16";
chomp $data_file;
open (DATA, $data_file) or die "\nCan't open $data_file, closing!!! \n";

# Initialise variables
#my ( @acc_version)
my $locus = '';


# Assign input record separator to the special entry divider // followed by new line \n
$/ = "//\n";

while ( my $gb_file_line = <DATA>){

	if($gb_file_line =~ /^LOCUS/){
		$gb_file_line =~ s/^LOCUS\s*//;
		$locus = $gb_file_line;
		print $locus;
	
	}
	
	
	
	#print $gb_file_line;	
	





}


close DATA;
1;
exit;

#my $cmd = 'rm chrom_CDS_16';
#system($cmd);