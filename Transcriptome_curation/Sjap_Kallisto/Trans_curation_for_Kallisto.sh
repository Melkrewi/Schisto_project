#concatenate the final z and w candidates.
cat Final_Set_W_Candidates_Japonicum.fasta Final_Set_Z_Candidates_Japonicum_17_11_2020.fasta > Final_Set_ZW_Candidates_Japonicum_17_11_2020.fasta

#use blat to find the copies in the transcriptomes that need to be removed
module load java
module load blat
blat -minScore=31 schistosoma_japonicum.PRJEA34885.WBPS14.CDS_transcripts.fa.long Final_Set_ZW_Candidates_Japonicum_17_11_2020.fasta ZW_vs_clean_trans.blat -t=dnax -q=dnax

#filter for matches > 100 and & mismatch/(match+mismatch)<'0.05'
cat ZW_vs_clean_trans.blat | awk '($1>100 && ($2/($1+$2+0.00000001))<0.05)' > filtered_all.txt

#remove all the transcripts in filtered_all from the collapsed transcriptome using
perl -ne 'if(/^>(\S+)/){$c=!$i{$1}}$c?print:chomp;$i{$_}=1 if @ARGV' remove.txt schistosoma_japonicum.PRJEA34885.WBPS14.CDS_transcripts.fa.long > schistosoma_japonicum_clean_CDS_17_11_2020.fasta

#add the Final_Set_ZW_Candidates_Japonicum_17_11_2020.fasta to the clean collapsed transcriptome
cat schistosoma_japonicum_clean_CDS_17_11_2020.fasta Final_Set_ZW_Candidates_Japonicum_17_11_2020.fasta > schistosoma_japonicum_CDS_Kallisto_17_11_2020.fasta
