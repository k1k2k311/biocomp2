#!/usr/bin/env perl

use strict;
use Tk;
use Biocomp2::Middle;

my $mw = new MainWindow; 
my $label = $mw -> Label(-text=>"Choose a gene") -> pack();
my $button = $mw -> Button(-text => "Show Details", 
        -command => sub { exit })
    -> pack();
my $quit_btn = $mw -> Button(-text => "Quit",
	-command => sub { exit })
    -> pack();
my $genes_lb = $mw->Listbox()->pack();
# show user a list of genes to pick from
my ($gene_id_array_ref, $gene_labels_array_ref) = get_genes();
$genes_lb->insert('end', @$gene_labels_array_ref);
MainLoop;

sub get_genes() {
  my %all_genes = Biocomp2::Middle::get_genes();
  my @gene_ids;
  my @gene_labels;
  foreach my $gene_id ( keys %all_genes ) {
    push @gene_ids, $gene_id;
    # deref array
    my @gene_details = @{$all_genes{$gene_id}};
    my $accession_version = @gene_details[0];
    print @gene_details;
    print "\n";
    print "$accession_version\n";
    my $gene_name = @gene_details[1];
    print "$gene_name\n";
    my $gene_product = @gene_details[3];
    print "$gene_product\n";
    my $gene_label = "$gene_name $gene_product";
    push @gene_labels, $gene_label;
    print "gene_id: $gene_id, value: $all_genes{$gene_id}\n";
  }
  return (\@gene_ids, \@gene_labels);
}
