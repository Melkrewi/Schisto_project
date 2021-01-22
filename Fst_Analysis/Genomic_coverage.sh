module load java

module load bowtie2/2.3.4.1
module load soap/coverage


srun bowtie2-build schistosoma_japonicum.PRJEA34885.WBPS9.genomic.fa japonicum_genome

bowtie2 -x japonicum_genome -1 SRR12363890_1.fastq -2 SRR12363890_2.fastq --end-to-end --sensitive -p 8 -S 1.sam

bowtie2 -x japonicum_genome -1 SRR12363891_1.fastq -2 SRR12363891_2.fastq --end-to-end --sensitive -p 8 -S 2.sam

bowtie2 -x japonicum_genome -1 SRR12363892_1.fastq -2 SRR12363892_2.fastq --end-to-end --sensitive -p 8 -S 3.sam

bowtie2 -x japonicum_genome -1 SRR12363893_1.fastq -2 SRR12363893_2.fastq --end-to-end --sensitive -p 8 -S 4.sam

bowtie2 -x japonicum_genome -1 SRR12363894_1.fastq -2 SRR12363894_2.fastq --end-to-end --sensitive -p 8 -S 5.sam

bowtie2 -x japonicum_genome -1 SRR12363895_1.fastq -2 SRR12363895_2.fastq --end-to-end --sensitive -p 8 -S 6.sam

bowtie2 -x japonicum_genome -1 SRR12363896_1.fastq -2 SRR12363896_2.fastq --end-to-end --sensitive -p 8 -S 7.sam

bowtie2 -x japonicum_genome -1 SRR12363897_1.fastq -2 SRR12363897_2.fastq --end-to-end --sensitive -p 8 -S 8.sam

bowtie2 -x japonicum_genome -1 SRR12363898_1.fastq -2 SRR12363898_2.fastq --end-to-end --sensitive -p 30 -S 9.sam

bowtie2 -x japonicum_genome -1 SRR12363899_1.fastq -2 SRR12363899_2.fastq --end-to-end --sensitive -p 30 -S 10.sam

bowtie2 -x japonicum_genome -1 SRR12363900_1.fastq -2 SRR12363900_2.fastq --end-to-end --sensitive -p 30 -S 11.sam

bowtie2 -x japonicum_genome -1 SRR12363901_1.fastq -2 SRR12363901_2.fastq --end-to-end --sensitive -p 30 -S 12.sam

bowtie2 -x japonicum_genome -1 SRR12363902_1.fastq -2 SRR12363902_2.fastq --end-to-end --sensitive -p 30 -S 13.sam

bowtie2 -x japonicum_genome -1 SRR12363903_1.fastq -2 SRR12363903_2.fastq --end-to-end --sensitive -p 30 -S 14.sam

bowtie2 -x japonicum_genome -1 SRR12363904_1.fastq -2 SRR12363904_2.fastq --end-to-end --sensitive -p 30 -S 15.sam

bowtie2 -x japonicum_genome -1 SRR12363905_1.fastq -2 SRR12363905_2.fastq --end-to-end --sensitive -p 30 -S 16.sam

bowtie2 -x japonicum_genome -1 SRR12363906_1.fastq -2 SRR12363906_2.fastq --end-to-end --sensitive -p 30 -S 17.sam

bowtie2 -x japonicum_genome -1 SRR12363907_1.fastq -2 SRR12363907_2.fastq --end-to-end --sensitive -p 30 -S 18.sam

bowtie2 -x japonicum_genome -1 SRR12363908_1.fastq -2 SRR12363908_2.fastq --end-to-end --sensitive -p 30 -S 19.sam

bowtie2 -x japonicum_genome -1 SRR12363909_1.fastq -2 SRR12363909_2.fastq --end-to-end --sensitive -p 30 -S 20.sam

bowtie2 -x japonicum_genome -1 SRR12363910_1.fastq -2 SRR12363910_2.fastq --end-to-end --sensitive -p 30 -S 21.sam

bowtie2 -x japonicum_genome -1 SRR12363911_1.fastq -2 SRR12363911_2.fastq --end-to-end --sensitive -p 30 -S 22.sam

for ((i=1; i<=22;i++))
do
grep -vw "XS:i" "$i".sam > "$i"_unique.sam
soap.coverage -sam -cvg -i "$i"_unique.sam -onlyuniq -p 8 -refsingle schistosoma_japonicum.PRJEA34885.WBPS9.genomic.fa -o "$i"_unique.soapcov
done
