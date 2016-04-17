-- CREATE DATABASE compbio2;
-- USE compbio2;

-- USE ri001; 

-- mysql -u ri001 -p'6xu1ornxo' ri001 < create.sql

DROP TABLE if exists chromosome16_genes;
CREATE TABLE chromosome16_genes
(
    gene_ID     INT             NOT NULL, 
    acc_ver     VARCHAR(20)     NOT NULL,
    gene       	VARCHAR(100)    DEFAULT 'N/A' NOT NULL,
    map			VARCHAR(20)     DEFAULT 'N/A' NOT NULL,
    product		VARCHAR(200)    DEFAULT 'N/A' NOT NULL,	
    protID		VARCHAR(20)     DEFAULT 'N/A' NOT NULL,
    aminoacid	TEXT    		,
    complement	VARCHAR(20)     NOT NULL,
    sequence	LONGTEXT     	NOT NULL,
	cod_start	INT	     		NOT NULL,


    PRIMARY KEY (gene_ID )
);


CREATE INDEX map_idx on chromosome16_genes(map);

DROP TABLE if exists coordinates;
CREATE TABLE coordinates
(
    gene_ID     	INT             NOT NULL, 
	exon_count		INT				NOT NULL,
    COOR_start     	INT			    NOT NULL,
    COOR_end       	INT 			NOT NULL,
	
	FOREIGN KEY (gene_ID) REFERENCES chromosome16_genes (gene_ID) ON DELETE CASCADE

)

