package Biocomp2::DnaTranslator;
use strict;
use warnings;

our %translation_table;
our %complement_table;

sub INIT {
  %translation_table = (
    'aaa' => 'K',
    'aac' => 'N',
    'aag' => 'K',
    'aat' => 'N',
    'aca' => 'T',
    'acc' => 'T',
    'acg' => 'T',
    'act' => 'T',
    'aga' => 'R',
    'agc' => 'S',
    'agg' => 'R',
    'agt' => 'S',
    'ata' => 'I',
    'atc' => 'I',
    'atg' => 'M',
    'att' => 'I',
    'caa' => 'Q',
    'cac' => 'H',
    'cag' => 'Q',
    'cat' => 'H',
    'cca' => 'P',
    'ccc' => 'P',
    'ccg' => 'P',
    'cct' => 'P',
    'cga' => 'R',
    'cgc' => 'R',
    'cgg' => 'R',
    'cgt' => 'R',
    'cta' => 'L',
    'ctc' => 'L',
    'ctg' => 'L',
    'ctt' => 'L',
    'gaa' => 'E',
    'gac' => 'D',
    'gag' => 'E',
    'gat' => 'D',
    'gca' => 'A',
    'gcc' => 'A',
    'gcg' => 'A',
    'gct' => 'A',
    'gga' => 'G',
    'ggc' => 'G',
    'ggg' => 'G',
    'ggt' => 'G',
    'gta' => 'V',
    'gtc' => 'V',
    'gtg' => 'V',
    'gtt' => 'V',
    'taa' => '-',
    'tac' => 'Y',
    'tag' => '-',
    'tat' => 'Y',
    'tca' => 'S',
    'tcc' => 'S',
    'tcg' => 'S',
    'tct' => 'S',
    'tga' => '-',
    'tgc' => 'C',
    'tgg' => 'W',
    'tgt' => 'C',
    'tta' => 'L',
    'ttc' => 'F',
    'ttg' => 'L',
    'ttt' => 'F'
  );
  %complement_table = (
    'a' => 't',
    'g' => 'c',
    'c' => 'g',
    't' => 'a'
  );
}


sub translate {
  my ($coding_sequence) = @_;
#  print "coding_sequence: $coding_sequence\n";
  my $residues = "";

  my @codons;
  while (length $coding_sequence >= 3) {
     my $codon= substr $coding_sequence, 0, 3;
     $coding_sequence = substr $coding_sequence, 3;
     my $residue = $translation_table{$codon};
     # append residue
     $residues .= $residue;
     push @codons, $codon;
  }
  return $residues;
}

sub complement {
  my ($dna_sequence) = @_;
  my $complement = "";
  for my $base (split //,$dna_sequence) {
    $complement .= $complement_table{$base};
  }
  return $complement;
}

sub reverse_complement {
  my ($dna_sequence) = @_;
  my $complement = complement($dna_sequence);
  return reverse $complement;
}

sub translate_all_frames {
  my ($dna_sequence) = @_;
  my %framesToResidues;
  # keys will be 2 characters [PN][012]
  # where P = positive strand, N = negative strand, and frame offset is 0, 1 or 2.
  $framesToResidues{"P0"} = translate($dna_sequence);
  $framesToResidues{"P1"} = translate(substr $dna_sequence, 1);
  $framesToResidues{"P2"} = translate(substr $dna_sequence, 2);
  my $complement = reverse_complement($dna_sequence);
  $framesToResidues{"N0"} = translate($complement);
  $framesToResidues{"N1"} = translate(substr $complement, 1);
  $framesToResidues{"N2"} = translate(substr $complement, 2);
  return %framesToResidues;
}
1;
