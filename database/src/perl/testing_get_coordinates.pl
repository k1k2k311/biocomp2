#!/usr/bin/perl
use CGI;
use Biocomp2::DataAccess;

#my @gene_details= Biocomp2::DataAccess::get_gene_details();  1869775   517348 7576255 3982606 27902681 2914675

#foreach my $element (@gene_deails) {
#
#	print $element, "\n";
#}

my @coordinates_aoa= Biocomp2::DataAccess::get_coordinates(63080987);


	for my $i ( 0 .. $#coordinates_aoa ) {
         my $row = $coordinates_aoa[$i];
         for my  $j ( 0 .. $#{$row} ) {
             print "element $i $j is $row->[$j]\n";
         }
     }


