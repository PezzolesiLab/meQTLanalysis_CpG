groupWD<-"/scratch/general/vast/u1311353/"
gTop<-read.table("../script/CpG_pheno.txt",header=T,
	stringsAsFactors=F,sep="\t")
pDir<-paste0(groupWD,"V2_meQTLanalysis_CpG14/min_model")

for(i in gTop[,1]){
	setwd(paste0(groupWD,"V2_meQTLanalysis_CpG14/min_model/output/",
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
	cat("#SBATCH --partition=pezzolesi-np\n")	
#	cat("#SBATCH --account=pezzolesi\n")
    	cat("#SBATCH --mail-type=FAIL\n")
    	cat("#SBATCH --mail-user=devorah.stucki@hsc.utah.edu\n")
	cat("\n")
	cat("module load R\n")
	cat(paste0("Rscript ../../../script/comb_chr.R ",i,"\n"))
	sink()
	system(paste0("sbatch ",i,".job"))
	Sys.sleep(10)
}
