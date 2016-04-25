# Middle layer documentation
author: Jurn Ho <jurn@magicmonster.com>

## module overview
This module is used by the front end CGI scripts,
and depends on the datalayer. It has been split into a few smaller
 modules that are not used directly.
Precalculated codon frequencies are stored in a CSV file,
as are the default set of enzymes that can cut DNA sequences.
![module diagram](module_overview.png "Module Overview")

## Middle module usage

### search
### get_genes
### get_gene_details
### get_overall_codon_frequencies
### calculate_custom_restriction_enzyme_sites

## example usage
See `dump_genes.pl` for sample code usage
