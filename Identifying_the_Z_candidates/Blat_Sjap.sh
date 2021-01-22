module load java
module load blat

blat -minScore=50 Trinity_cap3.fasta Final_Set_W_Candidates_Japonicum.fasta W_vs_trinity.blat -t=dnax -q=dnax

sort -k 10 W_vs_trinity.blat > W_vs_trinity.blat.sorted
perl 2-besthitblat.pl W_vs_trinity.blat.sorted
