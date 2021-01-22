module load java
module load samtools
module load bcftools 
module load vcftools

#first index the transcriptome
srun samtools faidx schistosoma_japonicum.PRJEA34885.WBPS9.genomic.fa


#Call SNPs from the BAM alignments
srun bcftools mpileup -a AD,DP,SP -Ou -f schistosoma_japonicum.PRJEA34885.WBPS9.genomic.fa 1.sorted.bam 2.sorted.bam 3.sorted.bam 4.sorted.bam 5.sorted.bam 7.sorted.bam 9.sorted.bam 10.sorted.bam 11.sorted.bam 12.sorted.bam 13.sorted.bam 14.sorted.bam 15.sorted.bam 16.sorted.bam 18.sorted.bam 19.sorted.bam 20.sorted.bam 21.sorted.bam 22.sorted.bam | bcftools call -v -f GQ,GP -mO z -o head.vcf.gz --threads 30
#filter for quality and coverage
srun vcftools --gzvcf head.vcf.gz --remove-indels --maf 0.1 --max-missing 0.9 --minQ 30 --min-meanDP 10 --max-meanDP 100 --minDP 10 --maxDP 100 --recode --stdout > head_filtered.vcf
#Filter 2: remove multiallelic
bcftools view --max-alleles 2 --exclude-types indels head_filtered.vcf > head_filtered2.vcf
srun vcftools --vcf head_filtered2.vcf --weir-fst-pop population_1.txt --weir-fst-pop population_2.txt --out pop1_vs_pop2
