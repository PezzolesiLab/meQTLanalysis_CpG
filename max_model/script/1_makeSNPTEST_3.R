groupWD<-"/uufs/chpc.utah.edu/common/home/pezzolesi-group1/"
#FIXME: change this path to match your output directory
setwd(paste0(groupWD,"Joslin_data/meQTLanalysis_CpG14/max_model/output"))
impute=paste0(groupWD,"Joslin_data/imputation_v3_20160516/JOSLIN_Merged")
#FIXME:change to match path to input file
gexp<-read.table("../input/snptest_pheno_14CpG_final.sample",header=T,stringsAsFactors=F,na="-9")
gexp<-gexp[-1,]
gName<-colnames(gexp)[6:ncol(gexp)]
gTop<-read.table("../script/CpG_pheno.txt",header=T,
	stringsAsFactors=F,sep="\t")
g<-gTop[,1]
#FIXME: make sure the path is correct
pDir<-paste0(groupWD,"Joslin_data/meQTLanalysis_CpG14/max_model/")

for(i in g){
	system(paste0("mkdir ",i))
	setwd(paste0("./",i))
	system("mkdir bash")
	system("mkdir out")
	setwd("./bash")
	#FIXME: change to match path to snptools
	snptest<-"~/software/snptest_v2.5.6_CentOS_Linux7.8.2003-x86_64_dynamic/snptest_v2.5.6"
	#FIXME:make sure this matches the path to the input file
	pheno<-paste0(pDir,"input/snptest_pheno_14CpG_final.sample")
	
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
		cat("#SBATCH --account=pezzolesi-np\n")
		cat("#SBATCH --partition=pezzolesi-np\n")
#                cat("#SBATCH --account=pezzolesi\n")
#                cat("#SBATCH --partition=ember\n")
    		cat("#SBATCH --mail-type=FAIL\n")
		#FIXME: change to match your email
    		cat("#SBATCH --mail-user=devorah.stucki@hsc.utah.edu\n")
		cmd<-paste0(snptest," -data ",impute,"/JOSLIN_Merged_chr",j,
			".dose.vcf.gz ",pheno,
			" -genotype_field GP -frequentist 1 ",
			"-pheno ",i,
			" -use_raw_phenotypes -cov_names gender AGE DUR logA1c CD8T CD4T NK Bcell Mono run ",
			"-method score -o ../out/chr",j,".max.out",
			" -missing_code -9")
		cat(cmd)
		sink()
		system(paste0("sbatch chr",j,".job"))
	}
	Sys.sleep(10)
	setwd("../../")
}
