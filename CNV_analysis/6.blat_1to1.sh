#! /bin/bash
#SBATCH --job-name="blat"
#SBATCH --mem=50G
#SBATCH --time=48:00:00
#SBATCH --output=2.blat_one-to-one.out

#-# last edit: 30-10-2020
#-# usage: qsub 2.blat_one-to-one.sh
#-# prog required: BLAT_v36x1
#-# description: Align with BLAT
            
## define variables:
CDS_mans="~/path-to-mansoni-genome/schistosoma_mansoni.PRJEA36577.WBPS14.CDS_transcripts.fa"
CDS_jap="~/path-to-japonicum-genome/schistosoma_japonicum.PRJEA34885.WBPS9.genomic.fa"

### start

module load blat/20170224

blat -q=dnax -t=dnax -minScore=50 ${CDS_jap} ${CDS_mans} CDSjap_CDSmans.blat

sort -k 10 CDSjap_CDSmans.blat > CDSjap_CDSmans.blat.sorted

### end  

