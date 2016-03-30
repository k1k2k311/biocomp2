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


my $annotation = '';
my $features = '';
my $sequence = '';

my $count = 0;

my $file = open_file($data_file);


while ($entry = get_entry($file) ) {

	($annotation, $features, $sequence) = split_entry($entry);
	#print "Annotation     ", $annotation ,"\n";
	#print $entry;
	print "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n";
	print "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n\n";
	print $count++, "\n";
	#print $annotation;
	#print $features;
	print $sequence;
	


}




1;
exit;


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

sub split_entry {

	my $entry = $_[0];
	my $n = scalar(@_);
	print "SCALAR     ", $n;
	my $annotation = '';
	my $feat = '';
	my $seq = '';

	$entry =~  /^(LOCUS.*)(FEATURES.*)ORIGIN(.*)\/\/\n/s;
	
	$annotation = $1;
	$features = $2;
	$seq = $3;
	$seq =~ s/\s*\d*//g;
	
	return($annotation, $features, $seq);



}





