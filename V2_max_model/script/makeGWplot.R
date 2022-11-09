# upload utilities
source("plotParameter.R")
#install.packages("Cairo")
#library(Cairo) # still needed?
# ------------------------------------------------------------------------------
options(bitmapType="cairo")

datall1 <- read.csv(fileA, header=T, as.is=T,sep="\t")
# rename columns
names(datall1)[which(names(datall1)==c("rsid"))]<-"MarkerName"
names(datall1)[which(names(datall1)==c("Pvalue"))]<-"pvalGC"
names(datall1)[which(names(datall1)==c("position"))]<-"Position"
names(datall1)[which(names(datall1)==c("chromosome"))]<-"Chromosome"
al<-c("A","C","G","T")
datall1<-datall1[datall1$alleleA %in% al & datall1$alleleB %in% al,]


# rename columns
AB2 <- datall1
#AB2$Chromosome <- as.numeric(AB2$Chromosome)
#AB2$Position <- as.numeric(AB2$Position)
# sort by chr and position
AB2 <- AB2[order(AB2$Chromosome,AB2$Position),]
nA  <- max(AB2$all_total)
stratumA <- ""
outname <- paste0("Manhattan_",title,".png")
# --------------------------------------------------------------------
# PLOT

# Define plot parameters
#color1 <- "red"
#color2 <- "blue"
cutoff<-5E-8
color1       <- gray(0.70) #Mandy's original color gray(0.70)
color2       <- gray(0.50) #Mandy's original color   
pch.type     <- 16      # symbol to be plotted
#pch.region   <- 22
pch.region   <- pch.type
sign.lines1   <- c(-log10(cutoff))
lines.colors <- c("dark grey")
# End of parameter definition 

AB2$log10p <- -log10(AB2$pvalGC)

#ymax <- ceiling(max(AB2$log10p, na.rm=T))
ymax <- min(20,ceiling(max(AB2$log10p, na.rm=T))) #Mandy's original 10 not 20 
ymin <- 0

AB2$abs_position <- 1:nrow(AB2)

# Manhattan plot
outfile<-outname
print(outfile)

png(outfile, width=2400, height=1600)
par(mar=c(7,8,5,3))
par(mgp=c(5,2,0))
vcex=2.5

plot(AB2$abs_position, AB2$log10p, type="n", yaxt="n", xaxt="n", 
	xlab="Chromosome", ylab=expression(-log[10]("P value")), 
	main=title, xlim=c(0,max(AB2$abs_position)), ylim=c(ymin,ymax), 
	cex.lab=vcex*1.1, cex.main=vcex*1.2)

chr <-  1:22
middle.points <- numeric(22)
for (i in 1:22)
   {
   idx <- AB2$Chromosome==i
   points(AB2$abs_position[idx], AB2$log10p[idx], col=ifelse(i%%2==0, 
	color1, color2), pch=pch.type, cex=1.4)
   middle.points[i] <- median(AB2$abs_position[idx])
   }

#added cex=1.4 to above to increase size by 40%; Mandy's original didn't have this


labels_y <- seq(from=ymin, to=ymax, by=1)
axis(side=2, at=labels_y, labels=abs(labels_y), tick=T, cex.axis=vcex*0.7, 
	las=1)
axis(side=1, at=middle.points, labels=as.character(c(1:22)), tick=T, 
	cex.axis=vcex, las=1)

abline(0,0)
abline(h=sign.lines1,lty="dotted",col=lines.colors, lwd=2)

text(100000,ymax, paste(stratumA," (n=",nA,")",sep=""), cex=vcex)

dev.off()

