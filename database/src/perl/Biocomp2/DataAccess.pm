package Biocomp2::DataAccess;
use strict;
use warnings;
use DBI;



sub bye {
  return "validating 44444";
}

sub get_gene_names {

	
	my $dbname   = "ri001";
	my $dbhost   = "hope.cryst.bbk.ac.uk";				#hope.cryst.bbk.ac.uk
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
    	#print "$gene_ID, $acc_ver \n";

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

	my $sql = 'SELECT gene_ID, acc_ver, locus  FROM chromosome16_genes';
	my $gene_ID = '';
	my $acc_ver = '';
	my $locus = '';
	my %gene_names;

    my $sth = $dbh->prepare($sql);
    $sth->execute;
    
    while(($gene_ID, $acc_ver, $locus) = $sth->fetchrow_array)
    {
    	#print "$gene_ID, $acc_ver \n";
		my @values = ($acc_ver, $locus);

		$gene_names{$gene_ID}= [ @values ];

	
	}

	return %gene_names;
	
}
sub save_gene {
	
	
	

}

1; 

