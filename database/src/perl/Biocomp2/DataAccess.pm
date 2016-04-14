package Biocomp2::DataAccess;
use strict;
use warnings;
use DBI;


sub get_gene_details {


	my $dbname   = "ri001";
	my $dbhost   = "hope.cryst.bbk.ac.uk";				#hope.cryst.bbk.ac.uk
	my $dbsource = "dbi:mysql:database=$dbname;host=$dbhost";
	my $username = "ri001";
	my $password = "6xu1ornxo";

	my $dbh = DBI->connect($dbsource, $username, $password) or die "Imposible conect to DataBase \n";


    my ($gene_ID) = @_;
	my $sql = "SELECT acc_ver, gene, map, product, protID  FROM chromosome16_genes WHERE gene_ID= $gene_ID";
	my $acc_ver = '';
	my $gene = '';
	my $map = '';
	my $product = '';
	my $protID = '';

	#print "MYSQL    ", $sql, "\n";

	my @gene_details;


	@gene_details= $dbh ->selectrow_array($sql);


    foreach my $element (@gene_details) {

        print $element;
    }

	#return @gene_details;

	my $gene_details_ref =  $dbh ->selectrow_hashref($sql);

	return $gene_details_ref;


}



sub get_gene_names {
	my $dbname   = "ri001";
	my $dbhost   = "hope.cryst.bbk.ac.uk";				
	my $dbsource = "dbi:mysql:database=$dbname;host=$dbhost";
	my $username = "ri001";
	my $password = "6xu1ornxo";
	
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

	
	my $dbname   = "ri001";
	my $dbhost   = "hope.cryst.bbk.ac.uk";				#hope.cryst.bbk.ac.uk
	my $dbsource = "dbi:mysql:database=$dbname;host=$dbhost";
	my $username = "ri001";
	my $password = "6xu1ornxo";

	my $dbh = DBI->connect($dbsource, $username, $password) or die "Imposible conect to DataBase \n";

	my $sql = 'SELECT gene_ID, acc_ver, gene, map, product, protID  FROM chromosome16_genes';

	my $gene_ID = '';
	my $acc_ver = '';
	my %gene_names;
	my  $gene = '';
	my  $map = '';
	my  $product = '';
	my  $protID = '';
	
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
	
	my $dbname   = "ri001";
	my $dbhost   = "hope.cryst.bbk.ac.uk";				#hope.cryst.bbk.ac.uk
	my $dbsource = "dbi:mysql:database=$dbname;host=$dbhost";
	my $username = "ri001";
	my $password = "6xu1ornxo";

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

	print "@@@@@@@@@@@@@@@\n\n";
	
	
	
	
	if (defined $dbh) {
	my $sql = "INSERT INTO chromosome16_genes (gene_ID, acc_ver, complement, gene, sequence, map, cod_start, product, protID, aminoacid) VALUES ('$gene_ID','$acc_ver','$complement', '$gene', '$sequence', '$map', '$cod_start', '$product', '$protID', '$aa')";
	$dbh->do($sql);
	#print "INSERT INTO chromosome16_genes  ", $gene_ID, "\n ", $acc_ver, "\n ",$complement, "\n ", $gene, "\n ", $sequence, "\n ", $map, "\n ", $cod_start, "\n ", $product, "\n ", $protID, "\n ", $aa, "\n\n";
		
	}

}


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




}

1; 

