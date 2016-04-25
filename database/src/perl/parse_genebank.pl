#!/usr/bin/perl
use strict;
use warnings;
use DBI;
use Data::Dumper qw(Dumper);
use Biocomp2::save_DB;
use Biocomp2::parser;



# Initialise variables
my $entry = '';
my %gene;
my %cordinates_hash;
my $count = 1;
my $compl_count = 1;
my $sense_count = 1;


# Open data file
my $data_file = "database/src/chrom_CDS_16";
chomp $data_file;
my $file = Biocomp2::parser::open_file($data_file);


# Split the genbank file in entries by genbank separator \\
while ($entry = Biocomp2::parser::get_entry($file) ) {

	# Split the entry in annotation, features and sequence
	my ($annotation, $features, $sequence) = Biocomp2::parser::split_entry($entry);

    # Marker new entry
	#print "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n\n";
	print "Parsing new entry\n";
	# Count number of entries
	print $count++, "\n";
	#print $annotation;
	#print $features;
	#print $sequence;

 	# From annotation parse gene_ID, accesion version and locus 
	my ($gene_ID, $acc_ver, $locus) = Biocomp2::parser::parse_annotation($annotation);

	# From features parse coordinates, complement, gene name, locus map, codon start, protein product and aminoacid seuqnce
	my ($cordinates_ref, $complement, $gene, $map, $cod_start, $product, $protID, $aa) = Biocomp2::parser::parse_features($features);
	# Dereference coordinates array
	my @cordinates = @$cordinates_ref;
	
	# Insert all in values to hash gene with the gene_ID as a key
	my @values = ($acc_ver, $complement, $gene, $sequence, $map, $cod_start, $product, $protID, $aa);
	$gene{$gene_ID} = [ @values ];                                                                                          # All details gene_ID

	# Insert coordinates array into coordinates hash
	$cordinates_hash{$gene_ID} = [ @cordinates ];                                                                           # Cordinates gene_ID



}

# Referenced hashes to DataAccess tier
Biocomp2::save_DB::save_genes(\%gene, \%cordinates_hash);                                                            # Referenced parsed genbank to DataAccess



1;
exit;



################################
#### Testing printing data #####
################################

#foreach my $key (keys %gene)
#{
# 	print "key $key value $gene{$key} \n";
#	print "key $key value1 @{ $gene{$key} } \n";
# 	print "Gene ID			", $key, "\n";
# 	my $acc_ver = @{ $gene{$key} }[0];
# 	print "AccesionVersion		", $acc_ver, "\n";
# 	my $complement = @{ $gene{$key} }[1];
# 	print "Complement		", $complement, "\n";
# 	my  $gene = @{ $gene{$key} }[2];
# 	print "Gene			", $gene, "\n";
# 	my  $sequence = @{ $gene{$key} }[3];
# 	print "Sequence		", $sequence, "\n";
# 	my  $map = @{ $gene{$key} }[4];
# 	print "Map			", $map, "\n";
# 	my  $cod_start = @{ $gene{$key} }[5];
# 	print "Cod Start		", $cod_start, "\n";
# 	my  $product = @{ $gene{$key} }[6];
# 	print "Product			", $product, "\n";
# 	my  $protID = @{ $gene{$key} }[7];
# 	print "Protein ID		", $protID, "\n";
# 	my  $aa = @{ $gene{$key} }[8];
# 	print "AA Sequence		", $aa, "\n";
#
# 	print "@@@@@@@@@@@@@@@\n\n";
#
#}


#
#foreach my $key (keys %cordinates_hash) {
#	print "###########    ", $key, "\n";
#	my @aoa = @{$cordinates_hash{$key}};
#
#	print Dumper \@aoa;
#
#
#	for my $i ( 0 .. $#aoa ) {
#         my $row = $aoa[$i];
#         for my  $j ( 0 .. $#{$row} ) {
#             print "element $i $j is $row->[$j]\n";
#         }
#     }
#
#}


