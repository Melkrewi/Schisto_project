#Trimming the reads:
module load java
srun java -jar ~/Trimmomatic-0.36/trimmomatic-0.36.jar PE -phred33 SRR8175618_1.fastq SRR8175618_2.fastq  SRR8175618_1_paired.fastq SRR8175618_1_unpaired.fastq SRR8175618_2_paired.fastq SRR8175618_2_unpaired.fastq ILLUMINACLIP:~/Trimmomatic-0.36/adapters/TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:140
