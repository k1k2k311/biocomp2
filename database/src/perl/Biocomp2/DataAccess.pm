package Biocomp2::DataAccess;
use strict;
use warnings;
use DBI;

my $dbname   = "ri001";
my $dbhost   = "hope.cryst.bbk.ac.uk";				#hope.cryst.bbk.ac.uk
my $dbsource = "dbi:mysql:database=$dbname;host=$dbhost";
my $username = "ri001";
my $password = "6xu1ornxo";


sub get_search {


	my $dbh = DBI->connect($dbsource, $username, $password) or die "Imposible conect to DataBase \n";


    my ($search_query) = @_;
	my $sql = "SELECT gene_ID, acc_ver, gene, map, product, protID  FROM chromosome16_genes WHERE product LIKE '%$search_query%' or gene_ID LIKE '%$search_query%' or map LIKE '%$search_query%' or acc_ver LIKE '%$search_query%'";
	#print "MYSQL		", $sql, "\n";	
	my $gene_ID = '';	
	my $acc_ver = '';
	my $gene = '';
	my $map = '';
	my $product = '';
	my $protID = '';
	my %gene_details;

    my $sth = $dbh->prepare($sql);
    $sth->execute;
    

    while(($gene_ID, $acc_ver, $gene, $map, $product, $protID) = $sth->fetchrow_array)
    {
    	#print "$gene_ID, $acc_ver \n";
		my @values = ($acc_ver, $gene, $map, $product, $protID);

		$gene_details{$gene_ID}= [ @values ];

	
	}


	return %gene_details;

}

sub get_coordinates {

	my $dbh = DBI->connect($dbsource, $username, $password) or die "Imposible conect to DataBase \n";

    my ($gene_ID_query) = @_;
	my $sql = "SELECT gene_ID, exon_count, COOR_start, COOR_end FROM coordinates WHERE gene_ID= $gene_ID_query";
	my $gene_ID = '';	
	my $exon_count = '';	
	my $COOR_start = '';
	my $COOR_end = '';
	my @cordinates;
	my %cordinates_hash;

    my $sth = $dbh->prepare($sql);
    $sth->execute;

    while(($gene_ID, $exon_count, $COOR_start, $COOR_end) = $sth->fetchrow_array)
    {

		my @add_cord = ($exon_count, $COOR_start, $COOR_end);
		push @cordinates, [@add_cord];	

	}
	return @cordinates;
}


sub get_sequence {

	my $dbh = DBI->connect($dbsource, $username, $password) or die "Imposible conect to DataBase \n";

    my ($gene_ID_query) = @_;
	my $sql = "SELECT sequence FROM chromosome16_genes WHERE gene_ID= $gene_ID_query";
	my $sequence = '';

	my $sth = $dbh->prepare($sql);
    $sth->execute;

	($sequence) = $dbh->selectrow_array($sql);

	return $sequence;
}

sub get_aa_sequence {

	my $dbh = DBI->connect($dbsource, $username, $password) or die "Imposible conect to DataBase \n";

    my ($gene_ID_query) = @_;
	my $sql = "SELECT aminoacid FROM chromosome16_genes WHERE gene_ID= $gene_ID_query";
	my $aminoacid = '';

	my $sth = $dbh->prepare($sql);
    $sth->execute;

	($aminoacid) = $dbh->selectrow_array($sql);

	return $aminoacid;
}


sub get_gene_details {

	my $dbh = DBI->connect($dbsource, $username, $password) or die "Imposible conect to DataBase \n";


    my ($gene_query) = @_;
	my $sql = "SELECT gene_ID, acc_ver, gene, map, product, protID  FROM chromosome16_genes WHERE gene_ID= $gene_query";

	my $gene_details_ref =  $dbh ->selectrow_hashref($sql);

	return $gene_details_ref;


}



sub get_gene_names {
	
	my $dbh = DBI->connect($dbsource, $username, $password) or die "Imposible conect to DataBase \n";
	
	my $sql = 'SELECT gene_ID, acc_ver  FROM chromosome16_genes';
	my $gene_ID = '';
	my $acc_ver = '';
	my %gene_names;
	
    my $sth = $dbh->prepare($sql);
    $sth->execute;
    
    while(($gene_ID, $acc_ver) = $sth->fetchrow_array)
    {
    	

		$gene_names{$gene_ID}=$acc_ver;

	
	}
	
	return %gene_names;
	
}



sub get_genes {

	my $dbh = DBI->connect($dbsource, $username, $password) or die "Imposible conect to DataBase \n";

	my $sql = 'SELECT gene_ID, acc_ver, gene, map, product, protID  FROM chromosome16_genes';

	my $gene_ID = '';
	my $acc_ver = '';
	my %gene_names;
	my $gene = '';
	my $map = '';
	my $product = '';
	my $protID = '';
	
    my $sth = $dbh->prepare($sql);
    $sth->execute;
    
    while(($gene_ID, $acc_ver, $gene, $map, $product, $protID) = $sth->fetchrow_array)
    {
    	#print "$gene_ID, $acc_ver \n";
		my @values = ($acc_ver, $gene, $map, $product, $protID);

		$gene_names{$gene_ID}= [ @values ];

	
	}

	return %gene_names;
	
}

sub save_genes {

	my $dbh = DBI->connect($dbsource, $username, $password) or die "Imposible conect to DataBase \n";

	my($gene_ref, $cordinates_hash_ref) = @_;
	print "Saving \n\n";
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
	my $sql = "INSERT INTO chromosome16_genes (gene_ID, acc_ver, complement, gene, sequence, map, cod_start, product, protID, aminoacid) VALUES ('$gene_ID','$acc_ver','$complement', '$gene', '$sequence', '$map', '$cod_start', '$product', '$protID', '$aa')";
	$dbh->do($sql);
	print "INSERT INTO chromosome16_genes  ", $gene_ID, "\n ", $acc_ver, "\n ",$complement, "\n ", $gene, "\n ", $sequence, "\n ", $map, "\n ", $cod_start, "\n ", $product, "\n ", $protID, "\n ", $aa, "\n\n";
		
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
		 print "Exon count			", $exon_count++, "\n";
		 
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
			my $sql = "INSERT INTO coordinates (gene_ID, exon_count, COOR_start, COOR_end) VALUES ('$gene_ID','$exon_count','$start','$end')";
			$dbh->do($sql);
			#print "INSERT INTO coordinates table  ", $gene_ID, "\n ", "EXON	", $exon_count, "\n ", "START	", $start, "\n ", "END	", $end, "\n";
			#print "INSERT INTO coordinates table  ", $gene_ID, "\n";
		 }	

     }

}


}

1; 

