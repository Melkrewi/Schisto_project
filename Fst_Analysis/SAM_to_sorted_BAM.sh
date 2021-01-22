module load java

module load bwa 

module load samtools 

for ((i=19; i<=22;i++))
do
srun samtools view -bS "$i".sam | samtools sort /dev/stdin -o "$i".sorted.bam 
done
