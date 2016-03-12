#!/usr/bin/perl
use strict;
use warnings;
use DBI;

my $cmd = 'wget http://www.bioinf.org.uk/teaching/bbk/biocomp2/data/chrom_CDS_16.gz';
system($cmd);

my $cmd = 'gunzip chrom_CDS_16.gz';
system($cmd);


# Open data file 
my $data_file = "chrom_CDS_16";
chomp $data_file;
open (DATA, $data_file) or die "Can't open $!, closing";

while ( my $gb_file = <DATA>){

	print $gb_file;	

}


close DATA;


my $cmd = 'rm chrom_CDS_16';
system($cmd);