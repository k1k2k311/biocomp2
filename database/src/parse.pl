#!/usr/bin/perl
use strict;
use warnings;
use DBI;


# Open data file 
my $data_file = "chrom_CDS_16";
chomp $data_file;
open (DATA, $data_file) or die "\nCan't open $data_file, closing!!! \n";

# Initialise variables
#my ( @acc_version)
my $locus = '';


# Assign input record separator to the special entry divider // followed by new line \n
$/ = "//\n";

my $entry = <DATA>;

while ( my $gb_line = <DATA>){

	if($gb_line =~ /^LOCUS/){
		$gb_line =~ s/^LOCUS\s*//;
		$locus = $gb_line;
		print $locus;
	
	}
	elsif($gb_line =~ /^ACCESSION/) {
		$gb_line =~ s/^ACCESSION\s*//;
		chomp($accession = $gb_line);
		#print $accession;
		
		
	}	
	elsif($gb_line =~ /^VERSION/) {
		$gb_line =~ s/^VERSION\s*//;
		$version = $gb_line;
		#print $version;
		if ( $version =~ m/^([A-Za-z0-9].*)\s*GI:(.*\n)/ ) {
			
			#print "VERSION  ", $1, "\n\n";
			#print "GENE_ID  ", $2, "\n\n";
			chomp($acc_ver = $1);
			chomp($gene_ID = $2);
			
			
		}
			
	}
	
	
	
	#print $gb_file_line;	
	





}


close DATA;
1;
exit;

#my $cmd = 'rm chrom_CDS_16';
#system($cmd);