#!/usr/bin/env perl

use strict;
use Tk;
use Biocomp2::Middle;

sub handle_show_details;

my $mw = new MainWindow; 
my $label = $mw -> Label(-text=>"Choose a gene") -> pack();
my $button = $mw -> Button(-text => "Show Details", 
        -command => sub { handle_show_details })
    -> pack();
my $quit_btn = $mw -> Button(-text => "Quit",
	-command => sub { exit })
    -> pack();
my $genes_lb = $mw->Listbox()->pack();
# show user a list of genes to pick from
my ($gene_id_array_ref, $gene_labels_array_ref) = get_genes();
$genes_lb->insert('end', @$gene_labels_array_ref);
MainLoop;

sub handle_show_details() {
  my $current_selection_ref = $genes_lb -> curselection();
  my @current_selection = @{$current_selection_ref}; 
  my $gene_id = @$gene_id_array_ref[$current_selection[0]];
}

sub get_genes() {
  my %all_genes = Biocomp2::Middle::get_genes();
  my @gene_ids;
  my @gene_labels;
  foreach my $gene_id ( keys %all_genes ) {
    push @gene_ids, $gene_id;
    # deref details hash
    my %details = %{$all_genes{$gene_id}};
    my $gene_name = $details{"name"};
    my $gene_product = $details{"product"};
    my $gene_label = "$gene_name $gene_product";
    push @gene_labels, $gene_label;
  }
  return (\@gene_ids, \@gene_labels);
}
