# Biocomputing II Project

## Members
* Igor Ruiz de los Mozos <i.mozos<at>ucl.ac.uk> 	Database layer
* Jurn Ho <jurn@magicmonster.com>
* Semina Efstratiou

## Requirements
We have been assigned chromosome 16.

[Requirements](http://www.bioinf.org.uk/teaching/bbk/biocomp2/project.html) are available from the
 module's website

[Raw data](http://www.bioinf.org.uk/teaching/bbk/biocomp2/data/chrom_CDS_16.gz) must be
downloaded and parsed.

## Installation
This has only been tested on on `hope`, a server that is internal to Birkbeck
crystallography.

To run and populate the database,
1. clone to repository
2. run `./RUN_DB.sh`

To work with an existing database:
1. run `./deploy.sh`

It is also possible to run scripts from the command line after setting up PERL5LIB. To do this:
1. run `./perl_env.sh`

