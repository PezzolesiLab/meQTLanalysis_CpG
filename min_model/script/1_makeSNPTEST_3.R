groupWD<-"/scratch/general/vast/u1311353/"
#FIXME: change this path to match your output directory
setwd(paste0(groupWD,"V2_meQTLanalysis_CpG14/min_model/output"))
impute=paste0("/uufs/chpc.utah.edu/common/home/pezzolesi-group1/Joslin_data/imputation_v3_20160516/JOSLIN_Merged")
#FIXME: change this file name to match the name of the input file
gexp<-read.table("../input/snptest_pheno_14CpG_finalv2.sample",header=T,stringsAsFactors=F,na="-9")
gexp<-gexp[-1,]
gName<-colnames(gexp)[6:ncol(gexp)]
#phenotype list
gTop<-read.table("../script/CpG_pheno.txt",header=T,
	stringsAsFactors=F,sep="\t")
g<-gTop[,1]
pDir<-paste0(groupWD,"V2_meQTLanalysis_CpG14/min_model/")

for(i in g){
	system(paste0("mkdir ",i))
	setwd(paste0("./",i))
	system("mkdir bash")
	system("mkdir out")
	setwd("./bash")
	#FIXME:change this line to match the path to the snptest executable
	snptest<-"~/software/snptest_v2.5.6_CentOS_Linux7.8.2003-x86_64_dynamic/snptest_v2.5.6"
	#FIXME:Make sure this path matches the input file
	pheno<-paste0(pDir,"input/snptest_pheno_14CpG_finalv2.sample")
	
	for(j in 1:22){
		sink(paste0("chr",j,".job"))
		cat("#!/bin/bash\n")
    		cat("#SBATCH --job-name=",i,"\n", sep="")
    		cat("#SBATCH --output=./chr",j,".out\n", sep="")
    		cat("#SBATCH --error=./chr",j,".err\n", sep="")
    		cat("#SBATCH --time=12:00:00\n")
    		cat("#SBATCH --mem=1000\n")
    		cat("#SBATCH -n 1\n")
		cat("#SBATCH -N 1\n")	
# 		 cat("#SBATCH -C \"em037\"\n")
		cat("#SBATCH --account=pezzolesi\n")
		cat("#SBATCH --partition=notchpeak\n")
#                cat("#SBATCH --account=pezzolesi\n")
#                cat("#SBATCH --partition=ember\n")
    		cat("#SBATCH --mail-type=FAIL\n")
    		cat("#SBATCH --mail-user=devorah.stucki@hsc.utah.edu\n")
		cmd<-paste0(snptest," -data ",impute,"/JOSLIN_Merged_chr",j,
			".dose.vcf.gz ",pheno,
			" -genotype_field GP -frequentist 1 ",
			"-pheno ",i,
			" -use_raw_phenotypes -cov_names AGE logegfr logA1c logACR Hypertension com_NK run ",
			"-method score -o ../out/chr",j,".min.out",
			" -missing_code -9")
		cat(cmd)
		sink()
		system(paste0("sbatch chr",j,".job"))
	}
	Sys.sleep(10)
	setwd("../../")
}
