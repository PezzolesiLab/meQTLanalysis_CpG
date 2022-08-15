groupWD<-"/uufs/chpc.utah.edu/common/home/pezzolesi-group1/"
gTop<-read.table("../script/KIM1_pheno_micronormo.txt",header=T,
	stringsAsFactors=F,sep="\t")
pDir<-paste0(groupWD,"Joslin_data/KIM1_project.MSDdata_analysis")

for(i in gTop[,1]){
	setwd(paste0(groupWD,"Joslin_data/KIM1_project.MSDdata_analysis/output/",
		i,"/out"))
	sink(paste0(i,".job"))
	cat("#!/bin/bash\n")
    	cat("#SBATCH --job-name=",i,"\n", sep="")
    	cat("#SBATCH --output=",i,".out\n", sep="")
    	cat("#SBATCH --error=",i,".err\n", sep="")
    	cat("#SBATCH --time=00:40:00\n")
    	cat("#SBATCH --mem=20000\n")
    	cat("#SBATCH -n 1\n")
	cat("#SBATCH -N 1\n")
	cat("#SBATCH -p pezzolesi-np\n")	
	cat("#SBATCH --account=pezzolesi-np\n")
    	cat("#SBATCH --mail-type=FAIL,END\n")
    	cat("#SBATCH --mail-user=marcus.pezzolesi@hsc.utah.edu\n")
	cat("\n")
	cat("module load R\n")
	cat(paste0("Rscript ../../../script/comb_chr.R ",i,"\n"))
	sink()
	system(paste0("sbatch ",i,".job"))
	Sys.sleep(10)
}
