#! /bin/bash

# OPTIONS

#SBATCH --job-name="bowtie2"
#SBATCH --output=bowtie2_mansoni.out
#SBATCH --cpus-per-task=3
#SBATCH --mem=25G
#SBATCH --time=48:00:00

# MORE INFOS

#-# last edit: 30-10-2020
#-# usage: qsub 1.bowtie2_mansoni.sh 
#-# prog required: bowtie (v2.3.4.1)
#-# description: Bowtie2 alignment of male RNAseq reads on mansoni genome

### START

inf="~/path-to-the-reads"
genome="~/path-to-the-genome/genome.fa"
ouf="~/path-to-output"

mkdir $ouf

module load bowtie2/2.3.4.1

## building index

bowtie2-build -f $genome mansoni_index
mv mansoni_index* $ouf

## aligning

bowtie2 -x $ouf/mansoni_index -1 $inf/ERR562989_forward_paired.fq.gz -2 $inf/ERR562989_reverse_paired.fq.gz -p 3 -S $ouf/mansoni_males.sam

bowtie2 -x $ouf/mansoni_index -1 $inf/ERR562990_forward_paired.fq.gz -2 $inf/ERR562990_reverse_paired.fq.gz -p 3 -S $ouf/mansoni_females.sam

### END

