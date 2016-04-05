#!/usr/bin/perl
use strict;
use warnings;
use DBI;
use Data::Dumper qw(Dumper);
use Biocomp2::DataAccess;

# Open data file 
my $data_file = "../chrom_CDS_16";
chomp $data_file;



my $annotation_flag = 0;
my $seq_flag = 0;
my $seq ='';
my @annot = '';

my $flag = 0;

#my $accession_version = '';


my $entry = '';
my %gene;
my %cordinates_hash;
my $count = 1;
my $compl_count = 1;
my $sense_count = 1;

my $file = open_file($data_file);


while ($entry = get_entry($file) ) {

	my $annotation = '';
	my $features = '';
	my $sequence = '';

	($annotation, $features, $sequence) = split_entry($entry);

	print "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n";
	#print "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n\n";
	print $count++, "\n";
	#print $annotation;
	#print $features;
	#print $sequence;
	
	
	my $gene_ID = '';
	my $acc_ver = '';
	my $locus = '';
	my @annotation; 
	@annotation = split /^/m, $annotation;			# split to array by start of the line
	#print "Size: ",scalar @annotation,"\n";
	#print @annotation;
	
	for my $annotation_line (@annotation) {
	#for my $annotation_line ($annotation) {
		if($annotation_line =~ /^LOCUS/) {
			$annotation_line =~ s/^LOCUS\s*//;
			chomp($locus = $annotation_line);
			#print $locus;
		}

	
		elsif($annotation_line =~ /^ACCESSION/) {
			$annotation_line =~ s/^ACCESSION\s*//;
			chomp(my $accession = $annotation_line);
			#print "Accesion	", $accession, "\n";
		
		
		}	
		elsif($annotation_line =~ /^VERSION/) {
			$annotation_line =~ s/^VERSION\s*//;
			my $version = $annotation_line;
			#print $version;
			if ( $version =~ m/^([A-Za-z0-9].*)\s*GI:(.*\n)/ ) {
			
				#print "VERSION  ", $1, "\n\n";
	
				chomp($acc_ver = $1);
				chomp($gene_ID = $2);
				print "GeneID		", $gene_ID, "\n";
				#print "AccVersion	", $acc_ver, "\n";
			
			}	
		}
	

	} # For annotation
	
	my ($cds, @cordinates, $complement, $gene, $map, $st_name, $cod_start, $product, $protID, $aa);

	foreach (my $features_line = $features){
		
		
		
		
		if ($features_line =~ /\/map="(.*)"/){
			$map = $1;
			#print "Map		", $map, "\n";
		}
		if($features_line =~ /CDS\s*(.[^\/]*?)\//m){			# Match everything (including \n) after CDS but / until /

			#print "COUNT  ", $count++, "\n";
			$cds = $1;
			$cds =~ s/(join)*\s*//g;							# Remove "join", lines and spaces
			print "CDS  ", $cds, "\n\n";
			
			
			
			
			if($cds =~ /^\(*complement(.*)/){					# Split by strand
				
				#print "1   ", $1, "\n";
				#print "2   ", $2, "\n";
				$complement = 1;											# Assign TRUE to complement
				print "COMPLEMENT ", $compl_count++, "\n";

				my @cord = split /,/, $1;									# Split by ,
				#print Dumper \@cord, "\n";
				for my $element (@cord){
					#print "ELEMENT  ", $element, "\n";
					$element =~ s/complement//g;
					if ($element =~ /\(*([0-9]*)\.\.([0-9]*)\)*/){			# Get the number upside to .. and downside to get the join accession = $1 ($element =~ /\(*(.*):([0-9]*)\.\.([0-9]*)\)*/)

						#print "START		", $1, "\n";
						#print "END    		", $2, "\n";					
						my @add_cord = ($1, $2);
						push @cordinates, [@add_cord];						# Add Start Stop cordinates
						#print Dumper \@cordinates, "\n";
					
					}
					
				}
	
			}
			else {  														# Positive strand
				$complement = 0;
				#print "SENSE      ", $cds, "\n";             
				print "POSITIVE     ", $sense_count++, "\n";
				
				my @cord = split /,/, $cds;									
				#print Dumper \@cord, "\n";
				for my $element (@cord){
					#print "ELEMENT  ", $element, "\n";						
					if ($element =~ /\(*([0-9]*)\.\.([0-9]*)\)*/){			

						#print "START		", $1, "\n";
						#print "END    		", $2, "\n";					
						my @add_cord = ($1, $2);
						push @cordinates, [@add_cord];						
						#print Dumper \@cordinates, "\n";
					
					}
					
				}
				
				
				
			}
			#print Dumper \@cordinates, "\n";								
		
		}
		if($features_line =~ /\/gene="(.*)"/){
			$gene = $1;
			#print "GENE		", $gene, "\n"; 
				
		}
		if($features_line =~ /\/standard_name="(.*)"/){
			$st_name = $1;
			#print "Std Name		", $st_name, "\n"; 
		
		}
		if($features_line =~ /\/codon_start=(\d*)/){
			$cod_start = $1;
			#print "Cod Start	", $cod_start, "\n";
		}
		if($features_line =~ /\/product="(.*)"/){
			$product = $1;
			#print "Product  	", $product, "\n";
		
		}
		if($features_line =~ /\/protein_id="(.*)"/){
			$protID = $1;
			#print "ProteinID	", $protID, "\n";
		
		
		}
		if($features_line =~ /\/translation=(.[^"]*?)"/s){			# Match /translation= and everything but " until "
			$aa = $1;
			$aa =~ s/"//g;
			#print "ProteinAA	", $aa, "\n";
			#print "COUNT  ", $count++, "\n";
		}		
		
						
	} # features

#($gene_ID, $acc_ver, @cordinates, $complement, $gene, $sequence, $map, $cod_start, $product, $protID, $aa)
#print "TEST    ", $protID, "\n\n";
####@cordinates
my @values = ($acc_ver, $complement, $gene, $sequence, $map, $cod_start, $product, $protID, $aa);
$gene{$gene_ID} = [ @values ];


$cordinates_hash{$gene_ID} = [ @cordinates ];


	
}

Biocomp2::DataAccess::save_genes(\%gene, \%cordinates_hash);



# foreach my $key (keys %gene)
# {
# 	#print "key $key value $genes{$key} \n";
# 	#print "key $key value1 @{ $genes{$key} } \n"
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
# }


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
	#my $n = scalar(@_);
	#print "SCALAR     ", $n;
	my $annot = '';
	my $feat = '';
	my $seq = '';

	$entry =~  /^(LOCUS.*)(FEATURES.*)ORIGIN(.*)\/\/\n/s;
	
	$annot = $1;
	$feat = $2;
	$seq = $3;
	$seq =~ s/\s*\d*//g;
	
	return($annot, $feat, $seq);


}





