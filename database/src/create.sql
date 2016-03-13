-- CREATE DATABASE compbio2;
-- USE compbio2;

USE ri001;


DROP TABLE chromosome;
CREATE TABLE chromosome
(
	prim_key	SMALLINT  		NOT NULL,
    gene_ID     INT             DEFAULT 'N/A' NOT NULL, 
    locus       VARCHAR(100)    DEFAULT 'N/A' NOT NULL,
    accession   VARCHAR(20)     DEFAULT 'N/A' NOT NULL,
	acc_ver     VARCHAR(20)     DEFAULT 'N/A' NOT NULL,
	

    PRIMARY KEY (prim_key)
);
CREATE INDEX locus_idx on chromosome(locus);

