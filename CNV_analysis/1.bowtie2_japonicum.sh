#! /bin/bash

# OPTIONS

#SBATCH --job-name="bowtie2"
#SBATCH --output=bowtie2_japonicum.out
#SBATCH --cpus-per-task=3
#SBATCH --mem=25G
#SBATCH --time=48:00:00

# MORE INFOS

#-# last edit: 2017-09-29
#-# usage: qsub 1.bowtie2_japonicum.sh 
#-# prog required: bowtie (v2-2.2.9)

### START

inf="~/path-to-the-reads"
genome="~/path-to-the-genome/schistosoma_japonicum.PRJEA34885.WBPS9.genomic.fa"
ouf="~/path-to-output"

mkdir $ouf

module load bowtie2/2.2.2.9

## building index

bowtie2-build -f $genome japonicum_index
mv japonicum_index* $ouf

## aligning

bowtie2 -x $ouf/japonicum_index -1 $inf/SRR6841388_forward_paired.fq.gz -2 $inf/SRR6841388_reverse_paired.fq.gz -p 3 -S $ouf/japonicum_females.sam

bowtie2 -x $ouf/japonicum_index -1 $inf/SRR6841389_forward_paired.fq.gz -2 $inf/SRR6841389_reverse_paired.fq.gz --end-to-end --sensitive -p 3 -S $ouf/japonicum_males.sam

### END


