#!/usr/bin/perl
use strict;
use warnings;
use DBI;


my $dbname   = "ri001";
my $dbhost   = "hope.cryst.bbk.ac.uk";
my $dbsource = "dbi:mysql:database=$dbname;host=$dbhost";
my $username = "ri001";
my $password = "6xu1ornxo";

my $dbh = DBI->connect($dbsource, $username, $password) or die "Imposible conect to DataBase \n";




my $file = 'chrom_CDS_16';

# Initialise variables
#my ( @acc_version)
my $locus = '';
my $version = '';
my $accession = '';
my $accession_version = '';
my $gene_ID = '';

my %annotation;
my $prim_key='';

my @genebank = file_to_array($file);

for my $gb_line (@genebank) {

	if($gb_line =~ /^LOCUS/) {
		$gb_line =~ s/^LOCUS\s*//;
		$locus = $gb_line;
		#print $locus;
	}

	
	elsif($gb_line =~ /^ACCESSION/) {
		$gb_line =~ s/^ACCESSION\s*//;
		$accession = $gb_line;
		#print $accession;
		
		
	}	
	elsif($gb_line =~ /^VERSION/) {
		$gb_line =~ s/^VERSION\s*//;
		$version = $gb_line;
		#print $version;
		if ( $version =~ m/^([A-Za-z0-9].*)\s*GI:(.*\n)/ ) {
			
			#print "VERSION  ", $1, "\n\n";
			#print "GENE_ID  ", $2, "\n\n";
			$acc_ver = $1;
			$gene_ID = $2;
			
			
		}
			
	}
	elsif($gb_line =~ /^\/\/\n/) {
		$prim_key ++;
		print $prim_key, "\n";
		my @scalar = '';
		@scalar = $accession_version, $locus;
		$annotation{$gene_ID} = @scalar;
		
		if (defined $dbh) {
			my $sql = "INSERT INTO chromosome (prim_key,gene_ID,locus,accession,acc_ver) VALUES ('$prim_key','$gene_ID','$locus','$accession','$acc_ver')";
			$dbh->do($sql);
			print "INSERT INTO chromosome  ", $prim_key, $gene_ID, $locus, $accession, $acc_ver, "\n\n";
		
		
	
		
	
	}


}

#print "###########  \n";
print $accession_version;
print $gene_ID;

# Print the fields
foreach my $key (keys %annotation) {
print "###########    ", $key, "\n";
print $annotation{$key};
}

#$sql = “INSERT INTO idac VALUES (‘LYC_CHICK’, ‘P00698’)”;
#$dbh->do($sql);



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
