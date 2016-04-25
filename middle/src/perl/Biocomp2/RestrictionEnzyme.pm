package Biocomp2::RestrictionEnzyme;
use strict;
use warnings;
use File::Basename;
use File::Spec;
use Biocomp2::DnaTranslator;

our %enzymes;

sub INIT {
  %enzymes = init_enzymes();
}

sub get_all_restriction_enzyme_sites {
  my ($dna_sequence, $exons_ref) = @_;
  my @exons = @{$exons_ref};
  my %restriction_sites;
  # for each enzyme, see where it cuts
  for my $enzyme (keys %enzymes) {
#    print "enzyme: $enzyme\n";
    my $enzyme_cutting_pattern = $enzymes{$enzyme};
#    print "pattern: $enzyme_cutting_pattern\n";
    # extract cut offset and regex
#    print "cut offset: $enzyme_cut_offset\n";
#    print "regexp: $enzyme_regexp\n";
#    print "sequence: $dna_sequence\n";
    my @sites = get_enzyme_sites($dna_sequence, $enzyme_cutting_pattern);
 #   print "sites: @sites\n";
    $restriction_sites{$enzyme} = \@sites;
  }
  return %restriction_sites;
}

sub get_enzyme_sites {
  my ($dna_sequence, $enzyme_cutting_pattern) = @_;
  $enzyme_cutting_pattern = lc $enzyme_cutting_pattern;
  my $enzyme_regexp = $enzyme_cutting_pattern;
  $enzyme_regexp =~ s/\^//;
  my $enzyme_cut_offset = index $enzyme_cutting_pattern, '^';
  my @sites;
  while ($dna_sequence =~ /$enzyme_regexp/g) {
    my $end_pos = pos($dna_sequence);
    my $start_pos = $end_pos - (length $enzyme_regexp);
    my $cut_pos = $start_pos + $enzyme_cut_offset;
    push @sites, $cut_pos;
  }
  return @sites;
}


sub init_enzymes {
  # read it from csv file
  my $dir = dirname(__FILE__);
  my $filename = File::Spec->catfile($dir, 'restriction_enzymes.csv');
  my %enzymes;
  print "filename: $filename\n";
  open(ENZYMES, "<", "$filename") or die "can't open file: $filename $!\n"; 
  while (my $line = readline(*ENZYMES)) {
    # remove newlines
    $line =~ s/[\n\r]//g;
    my @fields = split /,/, $line;
    my ($enzyme, $pattern) = @fields;
    $enzymes{$enzyme} = $pattern;
  }
  close(ENZYMES);
  return %enzymes;
}


1;

# EcoRI, BamHI and BsuMI
