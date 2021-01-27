#! /bin/bash

# OPTIONS

#SBATCH --job-name="soapcov"
#SBATCH --output=soapcov.out

#SBATCH --mem=50G
#SBATCH --time=24:00:00

# MORE INFOS

#-# last edit: 13-11-2020
#-# usage: qsub 4.soapcov_mansoni.sh 
#-# prog required: soap coverage

### START

#load module

module load soap/coverage

#define variable
inf="/nfs/scistore03/vicosgrp/mpicard/NEW_strata/bowtie2_mansoni"
genome="/nfs/scistore03/vicosgrp/mpicard/NEW_strata/mansoni/schistosoma_mansoni.PRJEA36577.WBPS14.genomic.fa"
ouf="/nfs/scistore03/vicosgrp/mpicard/NEW_strata/soapcov_mansoni"
win=10000

mkdir $ouf

#Select only uniquely mapped reads

cd $inf

for i in `ls | grep .sam`
do  
grep -vw 'XS:i' ${i} > ${i}_unique.sam 
done

#Obtain average genomic coverage for each scaffold

cd $inf

for l in `ls | grep _unique.sam`
do 
soap.coverage -sam -cvg -i ${l} -onlyuniq -refsingle $genome -o $ouf/${l}.soapcov -window $ouf/${l}.win10.soapcov 10000 
done


###END


