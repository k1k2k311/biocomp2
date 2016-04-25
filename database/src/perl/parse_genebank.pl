#!/usr/bin/perl
use strict;
use warnings;
use DBI;
use Data::Dumper qw(Dumper);
use Biocomp2::DataAccess;

my $entry = '';
my %gene;
my %cordinates_hash;
my $count = 1;
my $compl_count = 1;
my $sense_count = 1;


# Open data file
my $data_file = "database/src/chrom_CDS_16";
chomp $data_file;
my $file = open_file($data_file);


# Split the genbank file in entries by genbank separator \\
while ($entry = get_entry($file) ) {

	# Split the entry in annotation, features and sequence
	my ($annotation, $features, $sequence) = split_entry($entry);

	print "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n";
	#print "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n\n";
	print $count++, "\n";
	#print $annotation;
	#print $features;
	#print $sequence;

 	# From annotation parse gene_ID, accesion version and locus 
	my ($gene_ID, $acc_ver, $locus) = parse_annotation($annotation);

	# From features parse coordinates, complement, gene name, locus map, codon start, protein product and aminoacid seuqnce
	my ($cordinates_ref, $complement, $gene, $map, $cod_start, $product, $protID, $aa) = parse_features($features);
	# Dereference coordinates array
	my @cordinates = @$cordinates_ref;
	
	# Insert all in values to hash gene with the gene_ID as a key
	my @values = ($acc_ver, $complement, $gene, $sequence, $map, $cod_start, $product, $protID, $aa);
	$gene{$gene_ID} = [ @values ];                                                                                          # All details gene_ID

	# Insert coordinates array into coordinates hash
	$cordinates_hash{$gene_ID} = [ @cordinates ];                                                                           # Cordinates gene_ID



}

# Send referenced hashes to DataAccess tier
Biocomp2::DataAccess::save_genes(\%gene, \%cordinates_hash);                                                            # Referenced parsed genbank to DataAccess



1;
exit;

####################################
#### parse_genbank soubroutine #####
####################################


# Open file
sub open_file {

	my ($fin_name) = @_;
	my $fin;

	unless(open ($fin, $fin_name)) {
		print "\nCan't open $fin_name, closing!!! \n";
		exit;
	}
	return $fin;


}

# Split genbank file in diferent entries by genbank separator \\ 
sub get_entry {

	my ($file) = @_;
	my ($entry) = '';
	my ($reset_separator) = $/;                                     # Reset separator \n to special variable $/
	$/ = "//\n";                                                    # Assign separator to //n "end of genebank entry"

	$entry = <$file>;                                               # Assign all the entry to scalar

	$/ = $reset_separator;                                          # Reset separator

	return $entry;


}

# Split entry in annotation, features and sequence
sub split_entry {

	my ($entry) = @_;
	my $annot = '';
	my $feat = '';
	my $seq = '';

	$entry =~  /^(LOCUS.*)(FEATURES.*)ORIGIN(.*)\/\/\n/s;           # Match everithing after LOCUS FEATURES and ORIGING until //n "end of genebank entry"

	$annot = $1;
	$feat = $2;
	$seq = $3;
	$seq =~ s/\s*\d*//g;                                            # Remove all the spaces and digits from sequence

	return($annot, $feat, $seq);


}

# Parse annotation section
sub parse_annotation {


	my ($annotation) = @_;

	my $gene_ID = '';
	my $acc_ver = '';
	my $locus = '';
	my @annotation;

	@annotation = split /^/m, $annotation;			    # split to array by start of the line
	#print "Size: ",scalar @annotation,"\n";
	#print @annotation;

	for my $annotation_line (@annotation) {
	#for my $annotation_line ($annotation) {
		if($annotation_line =~ /^LOCUS/) {              # Get whole line begining with LOCUS
			$annotation_line =~ s/^LOCUS\s*//;
			chomp($locus = $annotation_line);
			#print $locus;
		}
		elsif($annotation_line =~ /^ACCESSION/) {
			$annotation_line =~ s/^ACCESSION\s*//;      # Get whole line begining with ACCESION
			chomp(my $accession = $annotation_line);
			#print "Accesion	", $accession, "\n";
		}
		elsif($annotation_line =~ /^VERSION/) {         # Get whole line begining with VERSION
			$annotation_line =~ s/^VERSION\s*//;
			my $version = $annotation_line;
			#print $version;
			if ( $version =~ m/^([A-Za-z0-9].*)\s*GI:(.*\n)/ ) {        # Get numbers and letters upstream 'GI:' and everithing downstream = gene_ID

				#print "VERSION  ", $1, "\n\n";

				chomp($acc_ver = $1);
				chomp($gene_ID = $2);
				print "GeneID		", $gene_ID, "\n";
				#print "AccVersion	", $acc_ver, "\n";
			}
		}
	} 

return($gene_ID, $acc_ver, $locus);
}


# Parse features section
sub parse_features {

	my ($features) = @_;

	my ($cds, @cordinates, $complement, $gene, $map, $st_name, $cod_start, $product, $protID, $aa); 

	foreach (my $features_line = $features){



		if ($features_line =~ /\/map="(.*)"/){                  # match everything quoted after /map=
			$map = $1;
			#print "Map		", $map, "\n";
		}
		if($features_line =~ /CDS\s*(.[^\/]*?)\//m){			# Match everything (including \n) after CDS but / until /

			#print "COUNT  ", $count++, "\n";
			$cds = $1;
			$cds =~ s/(join)*\s*//g;							# Remove "join", lines and spaces
			#print "CDS  ", $cds, "\n\n";

			if($cds =~ /^\(*complement(.*)/){					# Split by strand!!! Match after complement

				#print "1   ", $1, "\n";
				#print "2   ", $2, "\n";
				$complement = 1;											# Assign TRUE to complement strand
				#print "COMPLEMENT ", $compl_count++, "\n";

				my @cord = split /,/, $1;									# Split exons by ,
				#print Dumper \@cord, "\n";
				for my $element (@cord){
					#print "ELEMENT  ", $element, "\n";
					$element =~ s/complement//g;
					if	($element =~ /\(*(.*:)?([0-9]*)\.\.\>*([0-9]*)\)*/) {

                        if (defined $1){
                            #print "Splice Accesion version to join ", $1, "\n";     # Option DISCARDED not used alternative splice variants
                            next;
                        }
                        else {
                            #print "START		    ", $2, "\n";
						    #print "END    		    ", $3, "\n";
						    my @add_cord = ($2, $3);
						    push @cordinates, [@add_cord];						# Add Start Stop cordinates
						    #print Dumper \@cordinates, "\n";
                        }
					}
				}
			}
			else {  														# Positive strand
				$complement = 0;                                            # Assign FALSE to complement strand
				#print "SENSE      ", $cds, "\n";
				#print "POSITIVE     ", $sense_count++, "\n";

				my @cord = split /,/, $cds;									# Split exons by ,
				#print Dumper \@cord, "\n";
				for my $element (@cord){
					#print "ELEMENT  ", $element, "\n";
					#if ($element =~ /\(*([0-9]*)\.\.([0-9]*)\)*/){
					if	($element =~ /\(*(.*:)?([0-9]*)\.\.\>*([0-9]*)\)*/) {

                        if (defined $1){
                            #print "Splice Accesion version to join ", $1, "\n";     # Option DISCARDED not used alternative splice variants
                            next;
                        }
                        else {
                            #print "START		    ", $2, "\n";
						    #print "END    		    ", $3, "\n";
						    my @add_cord = ($2, $3);
						    push @cordinates, [@add_cord];						# Add Start Stop cordinates
						    #print Dumper \@cordinates, "\n";
                        }
					}
				}
			}
			#print Dumper \@cordinates, "\n";
		}
		if($features_line =~ /\/gene="(.*)"/){                              # Match everything quoted after /gene=
			$gene = $1;
			#print "GENE		", $gene, "\n";
		}
		if($features_line =~ /\/standard_name="(.*)"/){                     # Match everything quoted after /standard_name=
			$st_name = $1;
			#print "Std Name		", $st_name, "\n";
		}
		if($features_line =~ /\/codon_start=(\d*)/){                        # Match everything quoted after /codon_start=
			$cod_start = $1;
			#print "Cod Start	", $cod_start, "\n";
		}
		if($features_line =~ /\/product="(.*)"/){                           # Match everything quoted after /product=
			$product = $1;
			#print "Product  	", $product, "\n";
		}
		if($features_line =~ /\/protein_id="(.*)"/){                        # Match everything quoted after /protein_id=
			$protID = $1;
			#print "ProteinID	", $protID, "\n";
		}
		if($features_line =~ /\/translation=(.[^"]*?)"/s){			        # Match /translation= and everything but " until "
			$aa = $1;
			$aa =~ s/"//g;												   # Remove the quotation marks
			$aa =~ s/\s*\d*//g;                                            # Remove all the spaces and digits from sequence
			#print "ProteinAA	", $aa, "\n";
			#print "COUNT  ", $count++, "\n";
		}


	} 

return (\@cordinates, $complement, $gene, $map, $cod_start, $product, $protID, $aa);

}





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


