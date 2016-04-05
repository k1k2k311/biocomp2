#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper qw(Dumper);

my %coordinates_hash;
my @coordinates_array;

my @c1 = (7979, 8064);
push @coordinates_array, [@c1];

my @c2 = (10081, 10234);
push @coordinates_array, [@c2];

my $gene_id="gene222";

$coordinates_hash{$gene_id} = [@coordinates_array];
my @jurn = $coordinates_hash{$gene_id};

#print Dumper \@coordinates_array;
print "jurn start\n";
print Dumper \@jurn;
print "coordinates_array start\n";
print Dumper \@coordinates_array;
print $coordinates_array[1][1];

foreach my $key (keys %coordinates_hash) {
	print "###########    ", $key, "\n";
	my @aoa = @{$coordinates_hash{$key}};

	print Dumper \@aoa;


	for my $i ( 0 .. $#aoa ) {
        my $row = $aoa[$i];
        for my  $j ( 0 .. $#{$row} ) {
            print "element $i $j is $row->[$j]\n";
        }
    }

}