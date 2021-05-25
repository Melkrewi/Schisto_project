#! /bin/bash

#SBATCH --job-name=controlFREEC
#SBATCH -c 20
#SBATCH --time=72:00:00
#SBATCH --mem=500G

#-# last edit: 12-4-21

##MODULE(S)

module load samtools/1.11

##VARIABLE(S)

config="3.controlFREE.config"

###START

srun FREEC-11.6/src/freec -conf ${config}

###END


