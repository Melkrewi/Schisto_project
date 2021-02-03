#! /bin/bash

# OPTIONS

#SBATCH --job-name="kallisto_mans"
#SBATCH --mail-user=picardm@obs-banyuls.fr
#SBATCH --mail-type=END,FAIL
#SBATCH --output=kallisto_mans.out

#SBATCH --mem=8G
#SBATCH --time=24:00:00

# MORE INFOS

#-# last edit: 16-11-2020
#-# usage: qsub kallisto_index_mans.sh 
#-# prog required:  kallisto/0.43.1 
#-# description: kallisto is a program for quantifying abundances of transcripts from bulk and single-cell RNA-Seq data, or more generally of target sequences using high-throughput sequencing reads.  It is based on the novel idea of pseudoalignment for rapidly determining the compatibility of reads with targets, without the need for alignment. 
#-# more info here: https://pachterlab.github.io/kallisto/about.html

### START

TRANSCRIPTOME="/nfs/scistore03/vicosgrp/mpicard/NEW_expressionanalysis/schistosoma_mansoni_CDS_Kallisto_17_11_2020.fasta" ;
OUF_INDEX="/nfs/scistore03/vicosgrp/mpicard/NEW_expressionanalysis/kallisto_index_mansoni";


mkdir $OUF_INDEX

module load  kallisto/0.43.1 

# Create index

kallisto index -i $OUF_INDEX/transcripts.idx $TRANSCRIPTOME

### END

