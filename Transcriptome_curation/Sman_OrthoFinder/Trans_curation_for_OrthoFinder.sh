#merge the single CDS files from genewise:
for file in ~/final_cds/*_final_cds.fasta

do 

cat $file >> Mansoni_ZW_CDS_09_11_2020.fasta

done

#collapse the transcriptome using SpliceFinder.pl

perl SpliceFinder_2.pl schistosoma_mansoni.PRJEA36577.WBPS14.CDS_transcripts.fa

#remove the annotated candidates from Mansoni_ZW_CDS_09_11_2020.fasta

#use blat to find the copies in the transcriptomes that need to be removed
module load blat

blat -minScore=31 schistosoma_mansoni.PRJEA36577.WBPS14.CDS_transcripts.fa.long Mansoni_ZW_CDS_09_11_2020_without_smp.fasta ZW_vs_trans.blat -t=dnax -q=dnax

sort -k 10 ZW_vs_trans.blat > ZW_vs_trans.blat.sorted

perl 2-besthitblat.pl ZW_vs_trans.blat.sorted

#filter for matches > 100 and & mismatch/(match+mismatch)<'0.05'

cat ZW_vs_trans.blat | awk '($1>100 && ($2/($1+$2+0.00000001))<0.05)' > filtered_all.txt

#remove all the transcripts in filtered_all from the collapsed transcriptome
perl -ne 'if(/^>(\S+)/){$c=!$i{$1}}$c?print:chomp;$i{$_}=1 if @ARGV' remove.txt schistosoma_mansoni.PRJEA36577.WBPS14.CDS_transcripts.fa.long > schistosoma_mansoni_clean_CDS_17_11_2020.fasta

#add Mansoni_W_CDS_09_11_2020_without_smp_renamed.fasta to the clean collapsed transcriptome
cat schistosoma_mansoni_clean_CDS_17_11_2020.fasta Mansoni_W_CDS_09_11_2020_without_smp_renamed.fasta > schistosoma_mansoni_plus_ZW_orthofinder_17_11_2020.fasta
