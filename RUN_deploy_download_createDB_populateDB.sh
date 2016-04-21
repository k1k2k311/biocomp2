#!/bin/bash 

## Script Create database, download and extract the data, parse the genbank file and populate the database

echo "## Creating DataBase"
mysql -u ri001 -p'6xu1ornxo' ri001 < database/src/create.sql

echo "## Downloading and extracting GenBank file"
wget http://www.bioinf.org.uk/teaching/bbk/biocomp2/data/chrom_CDS_16.gz -O database/src/chrom_CDS_16.gz
gunzip database/src/chrom_CDS_16.gz > database/src/chrom_CDS_16
rm database/src/chrom_CDS_16.gz

echo "## Parse GeneBank file"
perl database/src/perl/parse_genebank.pl

echo "## Adjusting Enviroment"
./deploy.sh
./perl_env.sh
