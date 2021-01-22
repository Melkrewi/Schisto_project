fst<-read.table("pop1_vs_pop2.weir.fst", head=T, sep="\t")
fst_scaf<-aggregate(fst$WEIR_AND_COCKERHAM_FST, by=list(scaffold=fst$CHROM), mean)
colnames(fst_scaf)<-c("scaffold", "mean_fst")
write.table(fst_scaf, file="pop1_vs_pop2_MEANfst.txt", quote=F, row.names = F)
