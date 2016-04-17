#!/usr/bin/env perl

use strict;
use Tk;

my $mw = new MainWindow; 
my $label = $mw -> Label(-text=>"Hello World") -> pack();
my $button = $mw -> Button(-text => "Quit", 
        -command => sub { exit })
    -> pack();
MainLoop;
