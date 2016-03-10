package Biocomp2::Middle;
use strict;
use warnings;
use Biocomp2::DataAccess;

sub hello {
  my $ggg = Biocomp2::DataAccess::bye();
  return "testing6666  $ggg";
}

1;