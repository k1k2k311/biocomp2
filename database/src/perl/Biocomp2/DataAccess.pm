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
	my $sql = "SELECT gene_ID, acc_ver, gene, map, product, protID ".
		 		"FROM chromosome16_genes ".
				"WHERE product LIKE '%$search_query%' ".
				"OR gene_ID LIKE '%$search_query%' ".
				"OR map LIKE '%$search_query%' ".
				"OR acc_ver LIKE '%$search_query%'";
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
	my $sql = "SELECT co.gene_ID, co.exon_count, co.COOR_start, co.COOR_end, ch.complement, ch.cod_start ".
				"FROM coordinates co, chromosome16_genes ch ".
				"WHERE co.gene_ID = ch.gene_ID ".
				"AND ch.gene_ID= $gene_ID_query";

	my $gene_ID = '';	
	my $exon_count = '';	
	my $COOR_start = '';
	my $COOR_end = '';
	my $complement = '';
	my $cod_start = '';
	my @cordinates;
	my %cordinates_hash;

    my $sth = $dbh->prepare($sql);
    $sth->execute;

    while(($gene_ID, $exon_count, $COOR_start, $COOR_end, $complement, $cod_start) = $sth->fetchrow_array)
    {

		my @add_cord = ($exon_count, $COOR_start, $COOR_end, $complement, $cod_start);
		push @cordinates, [@add_cord];	

	}
	return @cordinates;
}


sub get_sequence {

	my $dbh = DBI->connect($dbsource, $username, $password) or die "Imposible conect to DataBase \n";

    my ($gene_ID_query) = @_;
	my $sql = "SELECT sequence ".
				"FROM chromosome16_genes ".
				"WHERE gene_ID= $gene_ID_query";
	my $sequence = '';

	my $sth = $dbh->prepare($sql);
    $sth->execute;

	($sequence) = $dbh->selectrow_array($sql);

	return $sequence;
}

sub get_aa_sequence {

	my $dbh = DBI->connect($dbsource, $username, $password) or die "Imposible conect to DataBase \n";

    my ($gene_ID_query) = @_;
	my $sql = "SELECT aminoacid ".
				"FROM chromosome16_genes ".
				"WHERE gene_ID= $gene_ID_query";
	my $aminoacid = '';

	my $sth = $dbh->prepare($sql);
    $sth->execute;

	($aminoacid) = $dbh->selectrow_array($sql);

	return $aminoacid;
}


sub get_gene_details {

	my $dbh = DBI->connect($dbsource, $username, $password) or die "Imposible conect to DataBase \n";


    my ($gene_query) = @_;
	my $sql = "SELECT gene_ID, acc_ver, gene, map, product, protID ".
				"FROM chromosome16_genes ".
				"WHERE gene_ID= $gene_query";

	my $gene_details_ref =  $dbh ->selectrow_hashref($sql);

	return $gene_details_ref;


}



sub get_gene_names {
	
	my $dbh = DBI->connect($dbsource, $username, $password) or die "Imposible conect to DataBase \n";
	
	my $sql = "SELECT gene_ID, acc_ver ".
				"FROM chromosome16_genes";
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

	my $sql = "SELECT gene_ID, acc_ver, gene, map, product, protID ".
				"FROM chromosome16_genes";

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

