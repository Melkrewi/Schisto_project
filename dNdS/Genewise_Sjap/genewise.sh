module load java

module load wise/2.4.1

module load blat

for (( i = 1; i <= 54; i++ ))

do

sed -n "$i"p  names_for_genewise.txt | cut -f 1 | sort | uniq | ~/seqtk/seqtk subseq Final_Set_W_Candidates_japonicum.fasta /dev/stdin > "$i"_w.fa

sed -n "$i"p  names_for_genewise.txt | cut -f 2 | sort | uniq | ~/seqtk/seqtk subseq schistosoma_mansoni.PRJEA36577.WBPS14.protein.fa /dev/stdin > "$i"_prot.fa

sed -n "$i"p  names_for_genewise.txt | cut -f 3 | sort | uniq | ~/seqtk/seqtk subseq Final_Set_Z_Candidates_japonicum_07_11_2020.fasta /dev/stdin > "$i"_z.fa

genewise -cdna "$i"_prot.fa "$i"_w.fa -both > "$i"_w.CDS

genewise -cdna "$i"_prot.fa "$i"_z.fa -both > "$i"_z.CDS

cat "$i"_w.CDS "$i"_z.CDS > "$i"_final_cds.fasta
done
