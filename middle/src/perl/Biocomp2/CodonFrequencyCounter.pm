package Biocomp2::CodonFrequencyCounter;
use strict;
use warnings;

sub _all_codons {
  my @bases = ('a','c','g','t') ;
  my @codons;
  for my $i (@bases) {
    for my $j (@bases) {
      for my $k (@bases) {
        my $codon = "$i$j$k";
	push @codons, $codon;
      }
    }
  }
  return @codons;
}


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
  # init results hash
  for my $codon (_all_codons()) {
    $result{$codon} = 0;
  }

  # count
  for my $codon (@codons) {
    if (! exists $result{$codon}) {
      # skip it
      next;
    }
    $result{$codon} = $result{$codon}+1;
  }
  return %result;
}
1;
