module load java

module load bbmap

kmercountexact.sh k=27 in1=40641_GTCCGC_1_paired.fq.gz in2=40641_GTCCGC_2_paired.fq.gz out=female_dna_mer_1.fa

kmercountexact.sh k=27 in=SRR4267990_trimmed.fq.gz out=sfemale_rna_schistosomula_mer_1.fa

kmercountexact.sh k=27 in=SRR4279491_trimmed.fq.gz out=sfemale_rna_schistosomula_mer_2.fa

kmercountexact.sh k=27 in1=SRR1421523_1.fastq in2=SRR1421523_2.fastq out=sfemale_rna_mature_adult_mer_1.fa

cat sfemale_rna_schistosomula_mer_1.fa sfemale_rna_schistosomula_mer_2.fa sfemale_rna_mature_adult_mer_1.fa > sfemale_rna_mer_1.fa

kmercountexact.sh k=27 in=female_dna_mer_1.fa,sfemale_rna_mer_1.fa out=shared_female_mer.fa mincount=2

bbduk.sh k=27 in=shared_female_mer.fa out=female_specific_mers.fasta ref=40640_ACTGAT_1_paired.fq.gz,40640_ACTGAT_2_paired.fq.gz -Xmx350g

bbduk.sh k=27 in=female_specific_mers.fasta out=v_female_specific_mers.fasta ref=SRR4267991_trimmed.fq.gz,SRR4279496_trimmed.fq.gz

bbduk.sh k=27 in=v_female_specific_mers.fasta out=v_v_female_specific_mers.fasta ref=SRR1421524_1.fastq,SRR1421524_2.fastq

bbduk.sh k=27 in=SRR4267990_trimmed.fq.gz outm=schistosomula_specific_rna_reads_1.fastq ref=v_v_female_specific_mers.fasta minkmerfraction=0.4

bbduk.sh k=27 in=SRR4279491_trimmed.fq.gz outm=schistosomula_specific_rna_reads_2.fastq ref=v_v_female_specific_mers.fasta minkmerfraction=0.4

bbduk.sh k=27 in1=SRR1421523_1.fastq in2=SRR1421523_2.fastq outm1=mature_adult_specific_rna_reads_1_1.fastq outm2=mature_adult_specific_rna_reads_1_2.fastq ref=v_v_female_specific_mers.fasta minkmerfraction=0.4
