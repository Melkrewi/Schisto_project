#improving the assembly of the W-Candidates using the 65-mer female assembly 
module load blat

module load  cap3/02-10-15

blat -minScore=50 TranscriptAssemblyK65.scafSeq Japonicum_transcripts_filtered_by_coverage.fasta /dev/stdout | awk '(($2/($1+$2+0.00000001))<0.01)' | cut -f 14 | sort | uniq | /nfs/scistore03/vicosgrp/bvicoso/SchistoW/1.5-ReassemblyOfAnkyrin/seqtk/seqtk subseq TranscriptAssemblyK65.scafSeq /dev/stdin > K65_maptoyourcandidate.fa

cap3 K65_maptoyourcandidate.fa -h 80 -o 40

#merge cap3 output with the filtered transcripts
cat Japonicum_transcripts_filtered_by_coverage.fasta K65_maptoyourcandidate.fa.cap.contigs > K65_plus_transcripts.fasta

#remove duplicates

perl SpliceFinder_2.pl K65_plus_transcripts.fasta

#Add SJ_W_ to the names of the transcripts
perl -p -e "s/^>/>SJ_W_/g" K65_plus_transcripts.fasta.long > Final_Japonicum_W_transcripts_renamed.fasta
