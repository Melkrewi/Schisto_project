### PART I ### DEFINING F:M COVERAGE LIMITS OF Z-SPECIFIC REGIONS IN S. MANSONI

################################################################
## STEP1: Loci assignment based on 2.5% coverage of autosomes ##
################################################################

## Set-up parameters
output="/home/marion/Bureau/SchistoPaper_TODO_24-01/Mat&Met/Rfiles/" ##Here indicate your outputfile name
spe="Smans" ##Here indicate the abbreviation of the studied species

## Read data
x=read.table("/home/marion/Bureau/SchistoPaper_TODO_24-01/Mat&Met/Rfiles/InputFile1_Smansoni_SoapCov_By10kb_ForR_NewG.csv",h=T) ##Here indicate your input table (5 columns modified SoapCoverage output)
head(x) #5columns: #Scaffold_ID #Window_start #Window_stop #ERR562990_Depth (i.e. female coverage) #ERR562989_Depth (i.e. male coverage)
tail(x) #5columns
nrow(x) #40958rows==number of analysed windows out of SoapCoverage analysis

## Calculate Log2(F:Mcov)
x$log2_FMcoverage <- log2(x$ERR562990_Depth/x$ERR562989_Depth)
head(x) #6columns: 6th column=="log2_FMcoverage"

## Histogram - Overall genomic coverage distribution
hist(x$log2_FMcoverage, breaks=400, xlim=c(-2,2), ylim=c(0,6000), col="antiquewhite3", main="F:M coverage distribution - S. mansoni", xlab="log2 (F:M) ratio of coverage")

## Subset depending on the location 
x_Autosomes  <- subset(x, x$Scaffold_ID=='SM_V7_1' | x$Scaffold_ID=='SM_V7_2' | x$Scaffold_ID=='SM_V7_3' | x$Scaffold_ID=='SM_V7_4' |x$Scaffold_ID=='SM_V7_5' |x$Scaffold_ID=='SM_V7_6' |x$Scaffold_ID=='SM_V7_7')
head(x_Autosomes) #6columns
tail(x_Autosomes) #6columns
nrow(x_Autosomes) #30429rows
x_ZW  <- subset(x, x$Scaffold_ID=='SM_V7_ZW') ## Just to insure that the sum of nrow are correct
nrow(x_ZW) #8839
x_UP <- subset(x, x$Scaffold_ID!='SM_V7_1' & x$Scaffold_ID!='SM_V7_2' & x$Scaffold_ID!='SM_V7_3' & x$Scaffold_ID!='SM_V7_4' & x$Scaffold_ID!='SM_V7_5' & x$Scaffold_ID!='SM_V7_6' & x$Scaffold_ID!='SM_V7_7' & x$Scaffold_ID!='SM_V7_8')
nrow(x_UP) #10529

## Determining minCov_Aut & maxCov_Aut
maxCov_Aut <- quantile(x_Autosomes$log2_FMcoverage,0.975,na.rm=T)
maxCov_Aut
maxCov_Aut_Graph <- round(maxCov_Aut,digits = 4)
minCov_Aut  <- quantile(x_Autosomes$log2_FMcoverage,0.025,na.rm=T) #### Further used limit
minCov_Aut
minCov_Aut_Graph <- round(minCov_Aut,digits = 4)

## Histogram - Autosomes
hist(x_Autosomes$log2_FMcoverage, breaks=600, xlim=c(-1,1), ylim=c(0,2500), col="gray37",border="gray50", main="F:M coverage distribution - Autosomes", xlab="log2 (F:M) ratio of coverage")
abline(v=maxCov_Aut,col="gray37",lwd=2,lty=2)
abline(v=minCov_Aut,col="sienna2",lwd=2,lty=2)
text((minCov_Aut_Graph-0.05),1000,paste("2.5%min_Aut: ", minCov_Aut_Graph),srt=90,col="sienna2")
text((maxCov_Aut_Graph-0.05),1000,paste("2.5%max_Aut: ", maxCov_Aut_Graph),srt=90,col="gray37")

## Vizualizing first step filter

# Subset Chr_ZW
x_ZW  <- subset(x, x$Scaffold_ID=='SM_V7_ZW') 

# Define color
colFactor <- x_ZW$log2_FMcoverage
colF <- rep("antiquewhite2",length(colFactor)) ; colF[which(colFactor>(minCov_Aut))] <- "gray37" ; colF[which(colFactor<(minCov_Aut))] <- "sienna2"
colF

# Plot coverage ratio F:M
plot(as.numeric(paste(x_ZW$Window_start)), log2(as.numeric(paste(x_ZW$ERR562990_Depth))/as.numeric(paste(x_ZW$ERR562989_Depth))), col=colF, ylim=c(-2,2), pch=16, xlab='Position on the Z-chromosome', ylab='log2 (F:M) ratio of coverage', main="F:M coverage along S. mansoni Z-chromosome")
legend(x="bottomright",paste(c("2.5% min_Aut","PAR","Non-PAR")),pch=c(NA,16,16),lty=c(2,NA,NA),lwd=c(2,NA,NA),col=c("sienna2","gray37","sienna2"),bty="n")
abline(h=minCov_Aut, col="sienna2", lty=2, lw=2)

## Generating first step table

# Define flags
Z <- which((x_ZW$log2_FMcoverage) < minCov_Aut)
PAR <- which((x_ZW$log2_FMcoverage) > minCov_Aut) 
flag <- rep("Ambiguous",nrow(x_ZW)) ; flag[Z] <- "Z" ; flag[PAR] <- "PAR"
x_ZW <- cbind(x_ZW,flag)
head(x_ZW)
nrow(x_ZW) #8839
nrow(subset(x_ZW,x_ZW$flag=="PAR")) #5431
nrow(subset(x_ZW,x_ZW$flag=="Z")) #3337
nrow(subset(x_ZW,x_ZW$flag=="Ambiguous")) #71

#Write filtered final table with flags
coln=NULL ; for(j in 1:length(colnames(x_ZW))){coln <- c(coln,paste(colnames(x_ZW)[j],spe,sep="_"))}
write.table(x_ZW,paste(output,"InputFile2_Zonly_10kb",".txt",sep=""),col.names=coln,row.names=F)

################################################################
## STEP2: Loci assignment based on 1% coverage of Zcandidates ##
################################################################

## Read data
x_Z=read.table(paste(output,"InputFile2_Zonly_10kb",".txt",sep=""),h=T,fill=TRUE)
head(x_Z) #7columns: 7th column=="flag_Smans" 
x_Z  <- subset(x_Z, x_Z$flag_Smans=="Z")
head(x_Z) #7columns: 7th column=="flag_Smans" should be only Z
tail(x_Z) #7columns
nrow(x_Z) #3337

## Determining minCov_Aut & maxCov_Aut
maxCov_Z <- quantile(x_Z$log2_FMcoverage_Smans,0.99,na.rm=T)
maxCov_Z #-0.3541866
maxCov_Z_Graph <- round(maxCov_Z,digits = 4)
minCov_Z  <- quantile(x_Z$log2_FMcoverage_Smans,0.01,na.rm=T) #### What's matter
minCov_Z #-1.101588
minCov_Z_Graph <- round(maxCov_Z,digits = 4)

## Histogram - Z chromosome
hist(x_Z$log2_FMcoverage_Smans, breaks=100, xlim=c(-2,0), ylim=c(0,200), col="sienna2", border="sienna1", main="F:M coverage distribution - Non-autosomes", xlab="log2 (F:M) ratio of coverage")
abline(v=maxCov_Z,col="gray37",lwd=2,lty=2)
abline(v=minCov_Z,col="sienna2",lwd=2,lty=2)
text(-1.15,100,paste("1%min_Z: ", minCov_Z_Graph),srt=90,col="sienna2")
text(-0.43,100,paste("1%max_Z: ", maxCov_Z_Graph),srt=90,col="gray37")

## Vizualizing second step filter
x=read.table("/home/marion/Bureau/SchistoPaper_TODO_24-01/Mat&Met/Rfiles/InputFile1_Smansoni_SoapCov_By10kb_ForR_NewG.csv",h=T) ##Here indicate your input table (5 columns modified SoapCoverage output)
x$log2_FMcoverage <- log2(x$ERR562990_Depth/x$ERR562989_Depth)
x_ZW  <- subset(x, x$Scaffold_ID=='SM_V7_ZW') 

# Plot coverage ratio F:M with ambiguous regions based on coverage only
colFactor <- x_ZW$log2_FMcoverage
colF <- rep("antiquewhite2",length(colFactor)) ; colF[which(colFactor>(minCov_Aut))] <- "gray37" ; colF[which(colFactor<(maxCov_Z))] <- "sienna2"
plot(as.numeric(paste(x_ZW$Window_start)), log2(as.numeric(paste(x_ZW$ERR562990_Depth))/as.numeric(paste(x_ZW$ERR562989_Depth))), col=colF,pch=16, ylim=c(-2,2), xlab='Position on the Z-chromosome', ylab='log2 (F:M) ratio of coverage', main="F:M genomic coverage distribution along S. mansoni Z-chromosome")
abline(h=minCov_Aut, col="sienna2", lty=2, lwd=2)
abline(h=maxCov_Z, col="gray37", lty=2, lwd=2)
legend(x="bottomright",paste(c("2.5% min_Aut","1% max_Z","Non-Zlinked","Zlinked","Ambiguous")),pch=c(NA,NA,16,16,16),lty=c(2,2,NA,NA,NA),lwd=c(2,2,NA,NA,NA),col=c("sienna2","gray37","gray37","sienna2","antiquewhite2"),bty="n")
