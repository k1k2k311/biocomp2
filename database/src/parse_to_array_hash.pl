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
			$accession_version = $1;
			chomp($accession_version);
			$gene_ID = $2;
			chomp($gene_ID);
			
			
		}
			
	}
	
	elsif($gb_line =~ /^\/\/\n/) {
		$prim_key ++;
		print $prim_key, "\n";
		
		my @values = ($prim_key, $accession_version, $locus );
		$annotation{$gene_ID} = [ @values ];
		
	}


}

#print "###########  \n";
#print $accession_version;
#print $gene_ID;

# Print the fields
# foreach my $key (keys %annotation) {
# print "###########    ", $key, "\n";
# print $annotation{$key};
# }

foreach my $key (keys %annotation)
{
	#print "key $key value $genes{$key} \n";
	#print "key $key value1 @{ $genes{$key} } \n"
	my $prim_key = @{ $annotation{$key} }[0];
	my $acc_ver = @{ $annotation{$key} }[1];
	my $locus = @{ $annotation{$key} }[2];
	print "KEY ········ $key .......\n";
	print $prim_key, "\n";
	print $acc_ver, "\n";
	print $locus, "\n";  
	
	print "@@@@@@@@@@@@@@@\n";  

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
