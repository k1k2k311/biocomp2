-- CREATE DATABASE compbio2;
-- USE compbio2;

-- USE ri001;
DROP TABLE if exists chromosome16_genes;
CREATE TABLE chromosome16_genes
(
    prim_key	SMALLINT        NOT NULL,
    gene_ID     INT             NOT NULL, 
    locus       VARCHAR(100)    DEFAULT 'N/A' NOT NULL,
    accession   VARCHAR(20)     DEFAULT 'N/A' NOT NULL,
    acc_ver     VARCHAR(20)     DEFAULT 'N/A' NOT NULL,
	

    PRIMARY KEY (prim_key)
);
CREATE INDEX locus_idx on chromosome16_genes(locus);

