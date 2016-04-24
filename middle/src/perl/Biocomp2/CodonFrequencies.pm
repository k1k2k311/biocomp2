package Biocomp2::CodonFrequencies;
use strict;
use warnings;
use File::Basename;
use File::Spec;

sub get_overall_codon_frequencies {
  # read it from csv file
  my $dir = dirname(__FILE__);
  my $filename = File::Spec->catfile($dir, 'codon_frequencies.csv');
  my %codon_frequencies;
  print "filename: $filename\n";
  open(CODONS, "<", "$filename") or die "can't open file: $filename $!\n"; 
  while (my $line = readline(*CODONS)) {
    # remove newlines
    $line =~ s/[\n\r]//g;
    my @fields = split /,/, $line;
    my ($codon, $frequency) = @fields;
    $codon_frequencies{$codon} = $frequency;
  }
  close(CODONS);
  return %codon_frequencies;
}

1;
