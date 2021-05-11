#! /bin/bash

#SBATCH --job-name="kallisto_mans_SRR"
#SBATCH --output=kallisto_mans_SRR.out
#SBATCH --mem=50G
#SBATCH --time=72:00:00

#Input with the library list: RUNlist.txt is a text file with a library number per line

mkdir ~/path-to-mansoni-kallisto-output/KalFiles #creating output folder
module load SRA-Toolkit/2.8.1-3
module load kallisto/0.43.1

#job
srun perl 3.Siliconer_mans_SRR.pl RUNlist.txt

