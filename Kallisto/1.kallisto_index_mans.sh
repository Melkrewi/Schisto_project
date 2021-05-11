#! /bin/bash

# OPTIONS

#SBATCH --job-name="kallisto_index_mans"
#SBATCH --output=kallisto_index_mans.out
#SBATCH --mem=8G
#SBATCH --time=24:00:00

# MORE INFOS

#-# last edit:  10-05-2021
#-# usage: qsub 1.kallisto_index_mans.sh 
#-# prog required:  kallisto/0.43.1 
#-# description: kallisto is a program for quantifying abundances of transcripts from bulk and single-cell RNA-Seq data, or more generally of target sequences using high-throughput sequencing reads.  It is based on the novel idea of pseudoalignment for rapidly determining the compatibility of reads with targets, without the need for alignment. 
#-# more info here: https://pachterlab.github.io/kallisto/about.html

### START

TRANSCRIPTOME="~/path-to-mansoni-curated-transcriptome/schistosoma_mansoni_CDS_Kallisto.fasta"
OUF="~/path-to-mansoni-kallisto-output"

mkdir $OUF
cd $OUF

module load kallisto/0.43.1 

# Create index
kallisto index -i $OUF/transcripts.idx $TRANSCRIPTOME

### END

