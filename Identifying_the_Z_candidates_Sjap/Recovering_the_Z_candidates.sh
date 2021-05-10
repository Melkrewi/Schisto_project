echo "### Step 7: Finding the Z candidates"

module load blat
blat -minScore=50 Trinity_cap3.fasta final_w_japonicum.fasta W_vs_trinity.blat -t=dnax -q=dnax

sort -k 10 W_vs_trinity.blat > W_vs_trinity.blat.sorted

perl 2-besthitblat.pl W_vs_trinity.blat.sorted

cat W_vs_trinity.blat.sorted.besthit | awk '($1>100)' > filtered_z.txt

cat filtered_z.txt | cut -f 14 > names_z_candidates.txt

perl -ne 'if(/^>(\S+)/){$c=$i{$1}}$c?print:chomp;$i{$_}=1 if @ARGV' names_z_candidates.txt Trinity_cap3.fasta > Final_Set_Z_Candidates_japonicum.fasta
