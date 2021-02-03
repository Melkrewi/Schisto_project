#! /bin/bash

#SBATCH --job-name="kallisto_mans_SRR"
#SBATCH --mail-user=picardm@obs-banyuls.fr
#SBATCH --mail-type=END,FAIL
#SBATCH --output=kallisto_mans_SRR.out

#SBATCH --mem=50G
#SBATCH --time=72:00:00

# RUNlist.txt is a text file with a library number per line

#modules to load
module load SRA-Toolkit/2.8.1-3
module load kallisto/0.43.1

#job
srun perl Siliconer_mansSRR.pl RUNlist.txt

