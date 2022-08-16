## Getting Started

### Instalation
Download SNPtools using the [online guide](https://www.well.ox.ac.uk/~gav/snptest/#download). 

### Set up
Correct the absolute path's in min_model/scripts and max_model/scripts. This includes changing the path to your input file and the absolute path to your install of SNPtools. The lines that need to be changed are marked in the file.
Add the list of genes you would like to run SNP tools on. Make sure the gene name matches the column name of the input file. This file should be saved as "CpG_pheno.txt", and formated like the example bellow
````
phenotype
gene1
gene2
gene3
...
````
 
##Functionality
For best results empty the output files before starting a new run.

SNPTEST analysis using Mandy's scripts:
Order to run scripts:
1. 1_makeSNPTEST_3.R
2. 2_afterSNPTEST_3.R
3. 3_afterSNPTESTplot_3.R

minimal model includes the following covariates: gender CD8T CD4T NK Bcell Mono run
maximal model includes the following covariates: gender AGE DUR logA1c CD8T CD4T NK Bcell Mono run