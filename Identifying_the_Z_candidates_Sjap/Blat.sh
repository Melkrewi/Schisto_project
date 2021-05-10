echo "### Step 7: Finding the Z candidates"

module load blat
blat -minScore=50 Trinity_cap3.fasta final_w_japonicum.fasta W_vs_trinity.blat -t=dnax -q=dnax

sort -k 10 W_vs_trinity.blat > W_vs_trinity.blat.sorted

perl 2-besthitblat.pl W_vs_trinity.blat.sorted
