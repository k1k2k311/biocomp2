#!/usr/bin/env perl
#

use strict;
use warnings;

use lib '../';

use Biocomp2::RestrictionEnzyme;
use Test::More;

my @exons;
my %restriction_sites = Biocomp2::RestrictionEnzyme::get_all_restriction_enzyme_sites("gaattc", \@exons);
my $ecori_sites_array_ref = $restriction_sites{'EcoRI'};
my @ecori_sites = @$ecori_sites_array_ref;
is($ecori_sites[0], 1, 'EcoRI cuts at position 1');

my %restriction_sites_multiple = Biocomp2::RestrictionEnzyme::get_all_restriction_enzyme_sites("gaattcgaattc", \@exons);
my $ecori_sites_array_ref_multiple = $restriction_sites_multiple{'EcoRI'};
my @ecori_sites_multiple = @$ecori_sites_array_ref_multiple;
is($ecori_sites_multiple[0], 1, 'EcoRI cuts at position 1');
is($ecori_sites_multiple[1], 7, 'EcoRI cuts at position 7');

done_testing;
