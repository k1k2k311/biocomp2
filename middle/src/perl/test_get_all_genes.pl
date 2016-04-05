#!/usr/bin/perl

use strict;
use warnings;

use Biocomp2::Middle;

my %genes = Biocomp2::Middle::get_all_genes();
foreach my $key ( keys %genes )
{
  print "key: $key, value: $genes{$key}\n";
}
