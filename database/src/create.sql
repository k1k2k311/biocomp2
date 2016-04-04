-- CREATE DATABASE compbio2;
-- USE compbio2;

-- USE ri001;
DROP TABLE if exists chromosome16_genes;
CREATE TABLE chromosome16_genes
(
    prim_key	SMALLINT        NOT NULL,
    gene_ID     INT             NOT NULL, 
    acc_ver     VARCHAR(20)     NOT NULL,
    gene       	VARCHAR(100)    DEFAULT 'N/A' NOT NULL,
    map			VARCHAR(20)     DEFAULT 'N/A' NOT NULL,
    product		VARCHAR(200)    DEFAULT 'N/A' NOT NULL,	
    protID		VARCHAR(20)     DEFAULT 'N/A' NOT NULL,
    aa			TEXT    		DEFAULT 'N/A' NOT NULL,	

    PRIMARY KEY (prim_key)
);
CREATE TABLE sequence
(
    prim_key	SMALLINT        NOT NULL,
    gene_ID     INT             NOT NULL, 
    cordinates	VARCHAR(100)    NOT NULL,
    complement	VARCHAR(20)     NOT NULL,
    sequence	LONGTEXT     	NOT NULL,
	cod_start	INT	     		NOT NULL,

    PRIMARY KEY (prim_key)
);

#($gene_ID, $acc_ver, @cordinates, $complement, $gene, $sequence, $map, $cod_start, $product, $protID, $aa)


CREATE INDEX locus_idx on chromosome16_genes(locus);

