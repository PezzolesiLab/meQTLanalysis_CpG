## Getting Started

### Dependencies
Download SNPtools using the [online guide](https://www.well.ox.ac.uk/~gav/snptest/#download).

### Instalation
Create output subdirectories in both the min_model directory and the max model directory. 

Create a softlink or place your data in the input directory.

Correct the absolute path's in min_model/scripts and max_model/scripts. This includes changing the path to your input file and the absolute path to your install of SNPtools. The lines that need to be changed are marked in the file. Add the list of CpG islands you would like to run SNP tools on. Make sure the name matches the column name of the input file. This file should be saved as "CpG_pheno.txt", and formated like the example bellow
````
phenotype
cg00000
cg00001
cg00002
...
````

## Execute Program
For best results empty the output files before starting a new run.

Order to run scripts:
````
1_makeSNPTEST_3.R
2_afterSNPTEST_3.R
3_afterSNPTESTplot_3.R
````

Minimal model includes the following covariates: gender CD8T CD4T NK Bcell Mono run

Maximal model includes the following covariates: gender AGE DUR logA1c CD8T CD4T NK Bcell Mono run
