for (( i = 1; i <= 75; i++ ))

do

sed -n "$i"p names_z_candidates.txt | cut -f 1 | sort | uniq | ~/seqtk/seqtk subseq Trinity_cap3.fasta /dev/stdin >> Final_Set_Z_Candidates_Japonicum_07_11_2020.fasta

done
