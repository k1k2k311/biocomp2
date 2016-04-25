# Biocomputing II Project

## Members
| team member | email | layer |
|-------------|-------|-------|
|Igor Ruiz de los Mozos|i.mozos at ucl.ac.uk|Database|
|Jurn Ho|<jurn@magicmonster.com>|middle|
|Semina Efstratiou|<aefstr01@mail.bbk.ac.uk>|UI|

## Requirements
We have been assigned chromosome 16.

[Web Project Page](http://student.cryst.bbk.ac.uk/cgi-bin/cgiwrap/ea001/index.pl)

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

## Usage
The main page show a list of all the gene records on the selected chromosome. Just chose your favorite gene cliching on the hiperlink on your right to acces the gene details, sequence (with hightlighted coding regions), clonning strategies and codon usages. Any time to your go backward to return to the main page. 

You could also seach on the database using the uper right corner search box. Seach will be performed on gene identifier, protein product name, locus map and accesion version. You will b
get all the results that the query apears and then filter by cliching on your desire gene to get strategies to clone it.

If you have any issue don hesitate to mail any of the developers. Happy browsing and clonning!!! 


## Architecture
![architecture diagram](arch_overview.png "Architecture Overview")
