package Biocomp2::CodonFrequencyCounter;
use strict;
use warnings;

sub get_frequencies {
  my ($coding_sequence) = @_;
#  print "coding_sequence: $coding_sequence\n";
  my %result;

  my @codons;
  while ($coding_sequence) {
     my $codon= substr $coding_sequence, 0, 3;
     $coding_sequence = substr $coding_sequence, 3;
     push @codons, $codon;
  }

  for my $codon (@codons) {
    if (exists $result{$codon}) {
      $result{$codon} = $result{$codon}+1;
    }
    else {
      $result{$codon} = 1;
    }
  }
  return %result;
}
1;