#merge the single CDS files from genewise:
for file in ~/final_cds/*_final_cds.fasta

do 

cat $file >> mansoni_ZW_CDS.fasta

done

#merge the single CDS files from genewise:

#collapse the transcriptome using SpliceFinder.pl

perl SpliceFinder_2.pl schistosoma_mansoni.PRJEA36577.WBPS14.CDS_transcripts.fa

#use blat to find the copies of the W-candidates in the transcriptome that need to be removed
module load blat

blat -minScore=31 schistosoma_mansoni.PRJEA36577.WBPS14.CDS_transcripts.fa.long mansoni_ZW_CDS.fasta ZW_vs_trans.blat -t=dnax -q=dnax

#filter for matches > 100 and & mismatch/(match+mismatch)<'0.05'
cat ZW_vs_trans.blat | awk '($1>100 && ($2/($1+$2+0.00000001))<0.05)' > filtered_all.txt
#remove all the transcripts in filtered_all from the collapsed transcriptome by listing all the transcripts in remove.txt and using the command below
perl -ne 'if(/^>(\S+)/){$c=!$i{$1}}$c?print:chomp;$i{$_}=1 if @ARGV' remove.txt schistosoma_mansoni.PRJEA36577.WBPS14.CDS_transcripts.fa.long > schistosoma_mansoni_clean_CDS.fasta

#add the w-candidates to the clean collapsed transcriptome
cat schistosoma_mansoni_clean_CDS.fasta mansoni_ZW_CDS.fasta > schistosoma_mansoni_plus_ZW_orthofinder.fasta
