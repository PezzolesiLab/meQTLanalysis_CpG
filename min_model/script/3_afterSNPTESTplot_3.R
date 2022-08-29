groupWD<-"/uufs/chpc.utah.edu/common/home/pezzolesi-group1/"
#FIXME: Change to match phenotype table
gTop<-read.table("../script/CpG_pheno.txt",header=T,
	stringsAsFactors=F,sep="\t")
#FIXME:Change to match working directory
pDir<-paste0(groupWD,"Joslin_data/meQTLanalysis_CpG14/min_model/")

for(i in gTop[,1]){
	#FIXME: change to match output directory
	setwd(paste0(groupWD,"Joslin_data/meQTLanalysis_CpG14/min_model/output/",
		i,"/out"))
	sink("plotParameter.R")
	cat(paste0("fileA=\"",i,"_MAF5_RSQ3_all_chr.txt","\"\n"))
	cat(paste0("title=\"",i,"\"\n"))
	sink()
	sink(paste0(i,".job"))
	cat("#!/bin/bash\n")
    	cat("#SBATCH --job-name=",i,"\n", sep="")
    	cat("#SBATCH --output=",i,".out\n", sep="")
    	cat("#SBATCH --error=",i,".err\n", sep="")
    	cat("#SBATCH --time=00:20:00\n")
    	cat("#SBATCH --mem=10000\n")
    	cat("#SBATCH -n 1\n")
	cat("#SBATCH -N 1\n")
	cat("#SBATCH -p pezzolesi-np\n")	
	cat("#SBATCH --account=pezzolesi-np\n")
    	cat("#SBATCH --mail-type=FAIL,END\n")
    	cat("#SBATCH --mail-user=devorah.stucki@hsc.utah.edu\n")
	cat("\n")
	cat("module load R\n")
	cat(paste0("Rscript ../../../script/makeGWplot.R \n"))
	sink()
	system(paste0("sbatch ",i,".job"))
	Sys.sleep(10)
}


