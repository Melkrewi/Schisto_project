### FIGURE 1 ###
rm(list=ls())

## Load libraries
library(readxl)
library(RColorBrewer)

## Define colors
color_S0jap_dark <- brewer.pal(3, "Greys")[3]
color_S0jap_light <- brewer.pal(3, "Greys")[2]
color_S0mans_dark <- brewer.pal(3, "Blues")[3]
color_S0mans_light <- brewer.pal(3, "Blues")[2]
color_S1jap_dark <- brewer.pal(7, "YlOrRd")[4]
color_S1jap_light <- brewer.pal(7, "YlOrRd")[2]
color_S1mans_dark <- brewer.pal(3, "PuRd")[3]
color_S1mans_light <- brewer.pal(3, "PuRd")[2]
color_S2jap_dark <- brewer.pal(7, "Greens")[6]
color_S2jap_light <- brewer.pal(7, "Greens")[3] 
color_W <- brewer.pal(11, "Spectral")[2]
color_PAR <- "lavenderblush4"

## Strata coordinates
PAR_1 <- 10.740979
S1mans_1 <- 21.065055
S0_1 <- 21.940031
S1mans_2 <- 23.467694
S0_2 <- 44.205957
S1jap_1 <- 45.023776
PAR_2 <- 46.909733
S1jap_2 <- 51.488898
S2jap <- 78.392064 # Last with FST >  90% all FST (FST90_all=78.392064)

################      
## S. mansoni ## ----
################

  ## Open table
  x_ZW <-read.table("",fill=TRUE,header=TRUE) # here a six column input file summarizing the soapcov output and strata assignment ($Scaffold_ID $Window_start $Window_stop $ERR562990_Depth $ERR562989_Depth $new_strata_assignment)
  head(x_ZW) #6columns 
  tail(x_ZW) #6columns
  nrow(x_ZW) #8839
  
  ## Transform coordinates in Mb
  x_ZW$Window_start_Mb <- x_ZW$Window_start/1000000
  x_ZW$Window_stop_Mb <- x_ZW$Window_stop/1000000
  
  ## Log2(F:Mcov) calculation
  x_ZW$log2_FMcoverage <- log2(x_ZW$ERR562990_Depth/x_ZW$ERR562989_Depth)
  
  ## Plot
  
  # Color depending on strata
  colFactor <- as.numeric(x_ZW$Window_stop_Mb)
  colF <- rep(color_PAR,length(colFactor)) ; colF[which((colFactor < S0_1 & colFactor > S1mans_1)|(colFactor < S0_2 & colFactor > S1mans_2))] <- color_S0mans_light ; colF[which((colFactor < S1mans_1 & colFactor > PAR_1)|(colFactor < S1mans_2 & colFactor > S0_1))] <- color_S1mans_light
  
  # Plot coverage
  plot.new() 
  par(mar=c(4,5,2,2))
  x=as.numeric(paste(x_ZW$Window_start_Mb))
  y=log2(as.numeric(paste(x_ZW$ERR562990_Depth))/as.numeric(paste(x_ZW$ERR562989_Depth)))  
  plot(x, y, col=colF, pch=16, ylim=c(-1.8,1.25),xlim=c(0,90.000000),cex.axis=1.5, cex.lab=1.5,adj="0.5", xlab='Position on S.mansoni Z-chromosome (Mb)', ylab='log2(F:M)coverage - S. mansoni')
  #title(main="A.",adj=0,font.main=2)
  #title(main="Schistosoma mansoni",adj=0.08,font.main=4)
  legend(x="bottomright",paste(c("S1man","S0man",'PAR')),pch=c(16,16),col=c(color_S1mans_light,color_S0mans_light,color_PAR),bty="n")
  
  # All W candidates
  W <- as.data.frame(read_excel(""))  # here a three column table containing the W-candidates: $Gene_ID_mans $First_Base_GFF_mans $W-candidate_mans
  head(W)
  nrow(W) #30
  W$First_Base_GFF_mans_Mb <- W$First_Base_GFF_mans/1000000
  par(new = T) 
  W_lines <- W$First_Base_GFF_mans_Mb
  abline(v=W_lines, col=color_W, lty=1, lwd=1)
  
  # Add strata coordinates
  abline(v=PAR_1,lty=2,col="grey")
  abline(v=S1mans_1,lty=2,col="grey")
  abline(v=S0_1,lty=2,col="grey")
  abline(v=S1mans_2,lty=2,col="grey")
  abline(v=S0_2,lty=2,col="grey")
  abline(v=S1jap_1,lty=2,col="grey")
  abline(v=PAR_2,lty=2,col="grey")
  abline(v=S1jap_2,lty=2,col="grey")
  
  rect(PAR_1, 1.10, S1mans_1, 1.30,col=color_S1mans_light,border=NA)
  #text(x=(S1mans_1+PAR_1)/2,y=(1.10+1.30)/2,labels="S1man",adj=c(0.5,0.5),col=color_S1mans_dark)
  text(x=(S1mans_1+PAR_1)/2,y=(1.10+1.30)/2,labels="S1man",adj=c(0.5,0.5),col="black")
  rect(S1mans_1, 1.10, S0_1, 1.30,col=color_S0mans_light,border=NA)
  rect(S0_1, 1.10, S1mans_2, 1.30, col=color_S1mans_light,border=NA)
  rect(S1mans_2, 1.10, S0_2, 1.30, col=color_S0mans_light,border=NA)
  #text(x=(S1mans_2+S0_2)/2,y=(1.10+1.30)/2,labels="S0man",adj=c(0.5,0.5),col=color_S0mans_dark)
  text(x=(S1mans_2+S0_2)/2,y=(1.10+1.30)/2,labels="S0man",adj=c(0.5,0.5),col="black")
  
  text(x=-2,y=(1.10+1.30)/2,labels="A.",adj=c(0.5,0.5),col="black", font=2, cex=1.5)

################
# S. japonicum # ----
################

## Open table
CovData <- as.data.frame(read_excel("")) #here the table containig S. japonicum coverage-based assignment (example Dataset4-sheet2: $Gene_ID_mans $Coverage_Assignment_mans $First_Base_GFF_mans $Scaffold_ID_jap $Depth_40640_jap_Picardetal2018 $Depth_40641_jap_Picardetal2018 $new_strata_assignment)
head(CovData) 
tail(CovData) 
nrow(CovData) #2249

## Transform coordinates in Mb
CovData$First_Base_GFF_mans_Mb <- CovData$First_Base_GFF_mans/1000000

## Log2(F:Mcov) calculation
CovData$log2FMcov <- log2(as.numeric(CovData$Depth_40641_jap)/as.numeric(CovData$Depth_40640_jap))
head(CovData)

## Plot

# Color depending on strata
colFactor_jap <- as.numeric(CovData$First_Base_GFF_mans_Mb)
colFactor_jap
colF_jap <- rep(color_PAR,length(colFactor_jap)) ; colF_jap[which((colFactor_jap < S0_1 & colFactor_jap > S1mans_1)|(colFactor_jap < S0_2 & colFactor_jap > S1mans_2))] <- color_S0jap_light ; colF_jap[which((colFactor_jap < S1jap_1 & colFactor_jap > S0_2)|(colFactor_jap < S1jap_2 & colFactor_jap > PAR_2))] <- color_S1jap_light
colF_jap

# Plot coverage
plot.new() 
par(mar=c(4,5,2,2))
x=CovData$First_Base_GFF_mans_Mb
y=CovData$log2FMcov
plot(x, y, pch=16, col=colF_jap, ylim=c(-1.8,1.25), ylab="log2(F:M)coverage - S. japonicum",xlim=c(0,90.000000),adj="0.5", cex.axis=1.5, cex.lab=1.5, xlab="Position on S.mansoni Z-chromosome (Mb)")
legend(x="bottomright",paste(c("S1jap","S0jap",'PAR')),pch=c(16,16),col=c(color_S1jap_light,color_S0jap_light,color_PAR),bty="n")

# all W candidates
W <- as.data.frame(read_excel(""))  # here a three column table containing the W-candidates: $Gene_ID_mans $First_Base_GFF_mans $W-candidate_jap
nrow(W) #39
W$First_Base_GFF_mans_Mb <- W$First_Base_GFF_mans/1000000
par(new = T) 
W_lines <- W$First_Base_GFF_mans_Mb
abline(v=W_lines, col=color_W, lty=1, lwd=1)

# Add strata coordinates
abline(v=PAR_1,lty=2,col="grey")
abline(v=S1mans_1,lty=2,col="grey")
abline(v=S0_1,lty=2,col="grey")
abline(v=S1mans_2,lty=2,col="grey")
abline(v=S0_2,lty=2,col="grey")
abline(v=S1jap_1,lty=2,col="grey")
abline(v=PAR_2,lty=2,col="grey")
abline(v=S1jap_2,lty=2,col="grey")

rect(S1mans_1, 1.10, S0_1, 1.30,col=color_S0jap_light,border=NA)
rect(S1mans_2, 1.10, S0_2, 1.30, col=color_S0jap_light,border=NA)
#text(x=(S1mans_2+S0_2)/2,y=(1.10+1.30)/2,labels="S0jap",adj=c(0.5,0.5),col=color_S0jap_dark)
text(x=(S1mans_2+S0_2)/2,y=(1.10+1.30)/2,labels="S0jap",adj=c(0.5,0.5),col="black")
rect(S0_2, 1.10, S1jap_1, 1.30, col=color_S1jap_light,border=NA)
rect(PAR_2, 1.10, S1jap_2, 1.30, col=color_S1jap_light,border=NA)
#text(x=(S1jap_2+PAR_2)/2,y=(1.10+1.30)/2,labels="S1jap",adj=c(0.5,0.5),col=color_S1jap_dark)
text(x=(S1jap_2+PAR_2)/2,y=(1.10+1.30)/2,labels="S1jap",adj=c(0.5,0.5),col="black")
text(x=-2,y=(1.10+1.30)/2,labels="B.",adj=c(0.5,0.5),col="black", font=2, cex=1.5)


#############
## meanFST ## ----
#############

## Open table to calculate FST90 value
FST_Data_all <- read.csv("", sep="")  # here FST table provided as supplementary data 5
hist(as.numeric(FST_Data_all$mean_fst), breaks=200, col="gray37",border="gray50", main="", xlab="")
FST90_all <- quantile(as.numeric(FST_Data_all$mean_fst),0.90)
FST90_all

## Subset FST table
FST_Data <- read.csv("", sep="") # here a combined table with FST values provided as supplementary data 5: $Gene_ID_mans $First_Base_GFF_mans $Scaffold_ID_jap $FST_jap 
head(FST_Data)
hist(as.numeric(FST_Data$FST_jap), breaks=200, col="gray37",border="gray50", main="", xlab="")
abline(v=FST90_all)

## Plot

# Color depending on FST value
colFactor_FST <- FST_Data$FST_jap
colF_FST <- rep(color_PAR,length(colFactor_FST)) ; colF_FST[which(colFactor_FST>(FST90_all))] <- color_S2jap_light
colF_FST

# Plot FST
plot.new() 
par(mar=c(4,5,2,2))
plot(as.numeric(paste(FST_Data$First_Base_GFF_mans_Mb)), as.numeric(paste(FST_Data$FST_jap)),ylim=c(-0.25,0.8),xlim=c(0,90.000000), pch=16, col=colF_FST, ylab="FST - S. japonicum",adj="0.5", cex.axis=1.5, cex.lab=1.5, xlab="Position on S.mansoni Z-chromosome (Mb)")
#legend(x="bottomright",paste(c("10% highest FST",'90% FST')),pch=c(16,16),col=c(color_S2jap_light,color_PAR),bty="n")
legend(x=80,y=-0.1,paste(c("10% highest FST",'90% FST')),pch=c(16,16),col=c(color_S2jap_light,color_PAR),bty="n")

par(new=T)
library(zoo)
y <- rollapply(as.numeric(paste(FST_Data$FST_jap)), width = 20, by = 1, FUN = mean, align="left")
x <- rollapply(as.numeric(paste(FST_Data$First_Base_GFF_mans_Mb)), width = 20, by = 1, FUN = mean, align="left")
plot(x, y, type = "l",lwd=2, col="black",ylim=c(-0.25,0.8),xlim=c(0,90.000000), axes=F, xlab="",ylab="")

# Add strata coordinates
abline(v=PAR_1,lty=2,col="grey")
abline(v=S1mans_1,lty=2,col="grey")
abline(v=S0_1,lty=2,col="grey")
abline(v=S1mans_2,lty=2,col="grey")
abline(v=S0_2,lty=2,col="grey")
abline(v=S1jap_1,lty=2,col="grey")
abline(v=PAR_2,lty=2,col="grey")
abline(v=S1jap_2,lty=2,col="grey")

rect(S1jap_2, 0.76, S2jap, 0.82,col=color_S2jap_light,border=NA)
rect(S1jap_1, 0.76, PAR_2, 0.82,col=color_S2jap_light,border=NA)
#text(x=(S1jap_2+S2jap)/2,y=(0.76+0.82)/2,labels="S2jap",adj=c(0.5,0.5),col=color_S2jap_dark)
text(x=(S1jap_2+S2jap)/2,y=(0.76+0.82)/2,labels="S2jap",adj=c(0.5,0.5),col="black")
text(x=-2,y=(0.76+0.82)/2,labels="C.",adj=c(0.5,0.5),col="black", font=2, cex=1.5)
