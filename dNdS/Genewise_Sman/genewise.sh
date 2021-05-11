#We used genewise to get the open reading frames for the 22 candidates that were not annotated
module load wise/2.4.1

module load blat

for (( i = 1; i <= 20; i++ ))

do

sed -n "$i"p  names_for_genewise.txt | cut -f 1 | sort | uniq | ~/seqtk/seqtk subseq Final_Set_W_candidates_mansoni.fasta /dev/stdin > "$i"_w.fa

sed -n "$i"p  names_for_genewise.txt | cut -f 2 | sort | uniq | /~/seqtk/seqtk subseq schistosoma_mansoni.PRJEA36577.WBPS14.protein.fa /dev/stdin > "$i"_prot.fa

sed -n "$i"p  names_for_genewise.txt | cut -f 3 | sort | uniq | ~/seqtk/seqtk subseq schistosoma_mansoni.PRJEA36577.WBPS14.CDS_transcripts.fa /dev/stdin > "$i"_z.fa

genewise -cdna "$i"_prot.fa "$i"_w.fa -both > "$i"_w.CDS

genewise -cdna "$i"_prot.fa "$i"_z.fa -both > "$i"_z.CDS

cat "$i"_w.CDS "$i"_z.fa > "$i"_final_cds.fasta
done


#formatting the annotated candidates 
for (( i = 21; i <= 40; i++ ))

do

sed -n "$i"p  names_for_genewise.txt | cut -f 1 | sort | uniq | ~/seqtk/seqtk subseq schistosoma_mansoni.PRJEA36577.WBPS14.CDS_transcripts.fa /dev/stdin > "$i"_w.fa

sed -n "$i"p  names_for_genewise.txt | cut -f 3 | sort | uniq | ~/seqtk/seqtk subseq schistosoma_mansoni.PRJEA36577.WBPS14.CDS_transcripts.fa /dev/stdin > "$i"_z.fa

cat "$i"_w.fa "$i"_z.fa > "$i"_final_cds.fasta
done

