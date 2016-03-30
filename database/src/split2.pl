#!/usr/bin/perl
use strict;
use warnings;
use DBI;


# Open data file 
my $data_file = "chrom_CDS_16";
chomp $data_file;


# Initialise variables
#my ( @acc_version)


my $annotation_flag = 0;
my $seq_flag = 0;
my $seq ='';
my @annot = '';
my $entry = '';
my $flag = 0;

my $accession_version = '';


my $file = open_file($data_file);

while ( $entry = get_entry($file)) {

	my $annotation = '';
	my $features = '';
	my $seq = '';
	my $version = '';
	my $acc_ver = '';

	$entry =~  /^(LOCUS.*)(FEATURES.*)ORIGIN(.*)\/\/\n/s;
	
	$annotation = $1;
	$features = $2;
	$seq = $3;
	$seq =~ s/\s*\d*//g;
	#
	print "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@";
	#print "Annotation     ", $annotation ,"\n";
	print "Features       ", $features ,"\n";
	#print "Sequence       ", $seq ,"\n";
	
}






1;
exit;


sub file_to_array {

	# get file name and initialise variable
	my ($fin_name) = @_;
	my @fin =();
	open (DATA, $fin_name) or die "\nCan't open fin_name, closing!!! \n";

	@fin = <DATA>;
	
	close DATA;
	return @fin;
	

}

sub open_file {

	my ($fin_name) = @_;
	my $fin;
	
	unless(open ($fin, $fin_name)) {
		print "\nCan't open fin_name, closing!!! \n";
		exit;
	}
	return $fin;


}

sub get_entry {

	my ($file) = @_;
	my ($entry) = '';
	my ($reset_separator) = $/;
	$/ = "//\n";
	
	$entry = <$file>;
	
	$/ = $reset_separator;
	
	return $entry;
	

}





