#merge the the single CDS to have a file with only coding Z and W to use for Orthofinder

for file in ~/final_cds/*_final_cds.fasta

do 

cat $file >> japonicum_ZW_CDS_09_11_2020.fasta

done

#collapse schistosoma_japonicum.PRJEA34885.WBPS14.CDS_transcripts.fa using SpliceFinder_2.pl

perl SpliceFinder_2.pl schistosoma_japonicum.PRJEA34885.WBPS14.CDS_transcripts.fa

#blat japonicum_ZW_CDS_09_11_2020.fasta against the collapsed transcriptome
blat -minScore=31 schistosoma_japonicum.PRJEA34885.WBPS14.CDS_transcripts.fa.long japonicum_ZW_CDS_09_11_2020.fasta ZW_vs_trans.blat -t=dnax -q=dnax

#filter for matches > 100 and & mismatch/(match+mismatch)<'0.05'
cat ZW_vs_trans.blat | awk '($1>100 && ($2/($1+$2+0.00000001))<0.05)' > filtered_all.txt

#remove all the transcripts in filtered_all from the collapsed transcriptome

perl -ne 'if(/^>(\S+)/){$c=!$i{$1}}$c?print:chomp;$i{$_}=1 if @ARGV' remove.txt schistosoma_japonicum.PRJEA34885.WBPS14.CDS_transcripts.fa.long > schistosoma_japonicum_clean_CDS_17_11_2020.fasta

#add japonicum_ZW_CDS_09_11_2020.fasta to the clean collapsed transcriptome

cat schistosoma_japonicum_clean_CDS_17_11_2020.fasta japonicum_ZW_CDS_09_11_2020.fasta > schistosoma_japonicum_plus_ZW_orthofinder_17_11_2020.fasta
