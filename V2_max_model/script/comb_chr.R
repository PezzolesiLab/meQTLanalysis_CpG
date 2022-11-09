combChr<-function(trait){
	groupWD<-"/scratch/general/vast/u1311353/"
	setwd(paste0(groupWD,"V2_meQTLanalysis_CpG14/max_model/output/",trait,
		"/out"))
	data<-c()
	for(j in 1:22){
		x<-read.table(paste0("chr",j,".max.out"),header=T,
			stringsAsFactors=F,fill=T)
		x<-x[!is.na(x$frequentist_add_pvalue) & 
			!is.na(x$frequentist_add_se_1),1:24]
		data<-rbind(data,x)
	}
        colnames(data)[21:24]<-c("Pvalue","INFO","BETA","SE")
	write.table(data,paste0(trait,"_all_chr.txt"),col.names=T,
		row.names=F,quote=F,sep="\t")
	write.table(data[data$all_maf>=0.05 & data$info>0.3,],
		paste0(trait,"_MAF5_RSQ3_all_chr.txt"),col.names=T,
		row.names=F,quote=F,sep="\t")
}

args<-commandArgs(TRUE)
TRAIT<-args[1]
combChr(TRAIT)
