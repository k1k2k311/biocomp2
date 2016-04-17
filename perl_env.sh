#!/bin/sh

BIOCOMP_TOP_DIR=$( cd $(dirname $0) ; pwd -P )
export PERL5LIB=$PERL5LIB:~hj001/perl5/lib/perl5/x86_64-linux-thread-multi
export PERL5LIB=$PERL5LIB:$BIOCOMP_TOP_DIR/database/src/perl
export PERL5LIB=$PERL5LIB:$BIOCOMP_TOP_DIR/middle/src/perl
PS1="biocomp2$ " $SHELL
