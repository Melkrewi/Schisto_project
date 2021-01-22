#Assembly using Trinity:

module load java
module load samtools/1.10
module load jellyfish/2.3.0
module load bowtie2/2.3.4.1
module load python/3.8.5
module load salmon/0.13.1


~/trinityrnaseq-v2.11.0/Trinity --seqType fa --left SRR8175618_1_paired_renamed.fasta --right SRR8175618_2_paired_renamed.fasta --CPU XX --max_memory XXG 
