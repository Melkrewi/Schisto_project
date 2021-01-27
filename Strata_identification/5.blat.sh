#! /bin/bash
#SBATCH --job-name="blat"
#SBATCH --mem=50G
#SBATCH --time=48:00:00
#SBATCH --output=1.blat.out

#-# last edit: 30-10-2020
#-# usage: qsub 1.blat.sh
#-# prog required: BLAT_v36x1 
#-# description: Align with BLAT 
			
## define variables:
CDS="/nfs/scistore03/vicosgrp/mpicard/NEW_strata/mansoni/schistosoma_mansoni.PRJEA36577.WBPS14.CDS_transcripts.fa"
GENOME="/nfs/scistore03/vicosgrp/mpicard/NEW_strata/japonicum/schistosoma_japonicum.PRJEA34885.WBPS14.genomic.fa"

### start

module load blat/20170224

blat -q=dnax -t=dnax -minScore=50 ${GENOME} ${CDS} GENOMEjap_CDSmans.blat

sort –k 10 GENOMEjap_CDSmans.blat > GENOMEjap_CDSmans.blat.sorted

### end

