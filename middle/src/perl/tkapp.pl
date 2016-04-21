#!/usr/bin/env perl

use strict;
use Tk;
use Biocomp2::Middle;

sub handle_show_details;

my $mw = new MainWindow; 
my $label = $mw -> Label(-text=>"Choose a gene") -> pack();
my $button = $mw -> Button(-text => "Show Details", 
        -command => sub { handle_show_details($mw) })
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
  my %details = Biocomp2::Middle::get_gene_details($gene_id);
  my $gene_name = $details{'name'};
  # make new window
  my $details_win = $mw->Toplevel( -title => "Gene Details $gene_id");
  my $gene_id_lbl = $details_win -> Label( -text => 'Gene ID:');
  my $gene_id_txt = $details_win -> Label( -text => $gene_id);
  my $gene_name_lbl = $details_win -> Label( -text => 'Gene Name:');
  my $gene_name_txt = $details_win -> Label( -text => $gene_name);
  my $accession_lbl = $details_win -> Label( -text => 'Accession:');
  my $accession_txt = $details_win -> Label( -text => $details{'accession_version'});
  my $locus_lbl = $details_win -> Label( -text => 'Locus:');
  my $locus_txt = $details_win -> Label( -text => $details{'locus'});
  my $product_lbl = $details_win -> Label( -text => 'Product:');
  my $product_txt = $details_win -> Label( -text => $details{'product'});
  my $protein_id_lbl = $details_win -> Label( -text => 'Protein ID:');
  my $protein_id_txt = $details_win -> Label( -text => $details{'protein_id'});
  my $sequence_lbl = $details_win -> Label( -text => 'Sequence:');
  my $sequence = $details{'sequence'};
  # add newlines
  my $sequence_with_lines = add_newlines($sequence);
  my $sequence_txt = $details_win -> Label( -text => "$sequence_with_lines");
  
  $gene_id_lbl-> grid($gene_id_txt);
  $gene_name_lbl -> grid ($gene_name_txt);
  $accession_lbl -> grid($accession_txt);
  $locus_lbl -> grid($locus_txt);
  $product_lbl -> grid($product_txt);
  $protein_id_lbl -> grid($protein_id_txt);
  $sequence_lbl -> grid($sequence_txt);

  my $details_close_btn = $details_win->Button( -text => 'Close', 
                                                -command => sub { $details_win -> destroy() } );
  $details_close_btn -> grid();
                                  
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

sub add_newlines() {
  my ($sequence) = @_;
  my $line_length = 60;
  my @lines;
  while ($sequence) {
    my $line = substr $sequence, 0, $line_length;
    $sequence = substr $sequence, $line_length;
    print "line: $line\n";
    push @lines, $line;
  }
  my $joined = join("\n",@lines);
  print "joined: $joined\n";
  return $joined;
}
