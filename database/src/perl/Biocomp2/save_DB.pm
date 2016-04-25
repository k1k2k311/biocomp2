package Biocomp2::save_DB;
use strict;
use warnings;
use DBI;

my $dbname   = "ri001";
my $dbhost   = "hope.cryst.bbk.ac.uk";				#hope.cryst.bbk.ac.uk
my $dbsource = "dbi:mysql:database=$dbname;host=$dbhost";
my $username = "ri001";
my $password = "6xu1ornxo";



sub save_genes {

	my $dbh = DBI->connect($dbsource, $username, $password) or die "Imposible conect to DataBase \n";

	my($gene_ref, $cordinates_hash_ref) = @_;
	my %cordinates_hash = %$cordinates_hash_ref;
	my %gene_hash = %$gene_ref;

foreach my $key (keys %gene_hash)
{
	my $gene_ID = $key;
	print "Gene ID			", $key, "\n";
	my $acc_ver = @{ $gene_hash{$key} }[0];
	#print "AccesionVersion		", $acc_ver, "\n";
	my $complement = @{ $gene_hash{$key} }[1];
	#print "Complement		", $complement, "\n";
	my  $gene = @{ $gene_hash{$key} }[2];
	#print "Gene			", $gene, "\n";
	my  $sequence = @{ $gene_hash{$key} }[3];
	#print "Sequence		", $sequence, "\n";
	my  $map = @{ $gene_hash{$key} }[4];
	#print "Map			", $map, "\n";
	my  $cod_start = @{ $gene_hash{$key} }[5];
	#print "Cod Start		", $cod_start, "\n";
	my  $product = @{ $gene_hash{$key} }[6];
	#print "Product			", $product, "\n";
	my  $protID = @{ $gene_hash{$key} }[7];
	#print "Protein ID		", $protID, "\n";
	my  $aa = @{ $gene_hash{$key} }[8];
	#print "AA Sequence		", $aa, "\n";

	#print "@@@@@@@@@@@@@@@\n\n";

	if (defined $dbh) {
	my $sql = "INSERT INTO chromosome16_genes (gene_ID, acc_ver, complement, gene, sequence, map, cod_start, product, protID, aminoacid) ".
				"VALUES ('$gene_ID','$acc_ver','$complement', '$gene', '$sequence', '$map', '$cod_start', '$product', '$protID', '$aa')";
	$dbh->do($sql);
	#print "INSERT INTO chromosome16_genes  ", $gene_ID, "\n ", $acc_ver, "\n ",$complement, "\n ", $gene, "\n ", $sequence, "\n ", $map, "\n ", $cod_start, "\n ", $product, "\n ", $protID, "\n ", $aa, "\n\n";
		
	}
	
}


#my $row_count = 1;
foreach my $key (keys %cordinates_hash) {

	print "###########    ", $key, "\n";
	my @coordinates_aoa = @{$cordinates_hash{$key}};
	my $gene_ID = $key;
	my $exon_count = 0;
	my $start = '';
	my $end = '';
	#print "ROW INDEX	", $row_count++, "\n";

	for my $i ( 0 .. $#coordinates_aoa ) {
         my $row = $coordinates_aoa[$i];
		 $exon_count++;
		 #print "Exon count			", $exon_count, "\n";
		 
         for my  $j ( 0 .. $#{$row} ) {
            #print "element $i $j is $row->[$j]\n";
			
			
			if ($j == 0) {
				$start = $row->[$j];
				#print "Coordinate Start		", $start, "\n";
			}
			elsif ($j == 1) {
				$end = $row->[$j];
				#print "Coordinate End  		", $end, "\n";
			}
			
         }

		 if (defined $dbh) {
			my $sql = "INSERT INTO coordinates (gene_ID, exon_count, COOR_start, COOR_end) ".
						"VALUES ('$gene_ID','$exon_count','$start','$end')";
			$dbh->do($sql);
			#print "INSERT INTO coordinates table  ", $gene_ID, "\n ", "EXON	", $exon_count, "\n ", "START	", $start, "\n ", "END	", $end, "\n";
			#print "INSERT INTO coordinates table  ", $gene_ID, "\n";
		 }	

     }

}


}

1; 

