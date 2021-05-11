#! /bin/bash

# OPTIONS

#SBATCH --job-name="kallisto_index_jap"
#SBATCH --output=kallisto_index_jap.out
#SBATCH --mem=8G
#SBATCH --time=24:00:00

# MORE INFOS

#-# last edit: 10-05-2021
#-# usage: qsub 5.kallisto_index_jap.sh 
#-# prog required: kallisto/0.43.1 

### START

TRANSCRIPTOME="~/path-to-japonicum-curated-transcriptome/schistosoma_japonicum_CDS_Kallisto.fasta"
OUF="~/path-to-japonicum-kallisto-output"

mkdir $OUF
cd $OUF

module load  kallisto/0.43.1 

# Create index

kallisto index -i $OUF/transcripts.idx $TRANSCRIPTOME

### END

