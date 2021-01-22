module load bowtie2/2.3.4.1

module load soap/coverage


srun bowtie2-build Final_Set_W_Candidates_Japonicum_plus_autosomes.fasta japonicum_W

srun bowtie2 -p 20 --no-unal --no-hd --no-sq -x japonicum_W -U SRR12363890_1.fastq -S s_1.sam

srun bowtie2 -p 20 --no-unal --no-hd --no-sq -x japonicum_W -U SRR12363891_1.fastq -S s_2.sam

srun bowtie2 -p 20 --no-unal --no-hd --no-sq -x japonicum_W -U SRR12363892_1.fastq -S s_3.sam

srun bowtie2 -p 20 --no-unal --no-hd --no-sq -x japonicum_W -U SRR12363893_1.fastq -S s_4.sam

srun bowtie2 -p 20 --no-unal --no-hd --no-sq -x japonicum_W -U SRR12363894_1.fastq -S s_5.sam

srun bowtie2 -p 20 --no-unal --no-hd --no-sq -x japonicum_W -U SRR12363895_1.fastq -S s_6.sam

srun bowtie2 -p 20 --no-unal --no-hd --no-sq -x japonicum_W -U SRR12363896_1.fastq -S s_7.sam

srun bowtie2 -p 20 --no-unal --no-hd --no-sq -x japonicum_W -U SRR12363897_1.fastq -S s_8.sam

srun bowtie2 -p 20 --no-unal --no-hd --no-sq -x japonicum_W -U SRR12363898_1.fastq -S s_9.sam

srun bowtie2 -p 20 --no-unal --no-hd --no-sq -x japonicum_W -U SRR12363899_1.fastq -S s_10.sam

srun bowtie2 -p 20 --no-unal --no-hd --no-sq -x japonicum_W -U SRR12363900_1.fastq -S s_11.sam

srun bowtie2 -p 20 --no-unal --no-hd --no-sq -x japonicum_W -U SRR12363901_1.fastq -S s_12.sam

srun bowtie2 -p 20 --no-unal --no-hd --no-sq -x japonicum_W -U SRR12363902_1.fastq -S s_13.sam

srun bowtie2 -p 20 --no-unal --no-hd --no-sq -x japonicum_W -U SRR12363903_1.fastq -S s_14.sam

srun bowtie2 -p 20 --no-unal --no-hd --no-sq -x japonicum_W -U SRR12363904_1.fastq -S s_15.sam

srun bowtie2 -p 20 --no-unal --no-hd --no-sq -x japonicum_W -U SRR12363905_1.fastq -S s_16.sam

srun bowtie2 -p 20 --no-unal --no-hd --no-sq -x japonicum_W -U SRR12363906_1.fastq -S s_17.sam

srun bowtie2 -p 20 --no-unal --no-hd --no-sq -x japonicum_W -U SRR12363907_1.fastq -S s_18.sam

srun bowtie2 -p 20 --no-unal --no-hd --no-sq -x japonicum_W -U SRR12363908_1.fastq -S s_19.sam

srun bowtie2 -p 20 --no-unal --no-hd --no-sq -x japonicum_W -U SRR12363909_1.fastq -S s_20.sam

srun bowtie2 -p 20 --no-unal --no-hd --no-sq -x japonicum_W -U SRR12363910_1.fastq -S s_21.sam

srun bowtie2 -p 20 --no-unal --no-hd --no-sq -x japonicum_W -U SRR12363911_1.fastq -S s_22.sam


for ((i=1; i<=22;i++))
do
awk '($6=="151M")' s_"$i".sam | grep 'NM:i:0' > s_"$i"_perfectmatch.sam

done

grep '>' Final_Set_W_Candidates_Japonicum_plus_autosomes.fasta | perl -pi -e 's/>//gi' | perl -pi -e 's/ .*//gi' > japonicum_W.list

for ((i=1;i<=22;i++))
do

cat s_"$i"_perfectmatch.sam | cut -f 3 | cat /dev/stdin japonicum_W.list | sort | uniq -c | awk '{print $2, $1-1}' > s_"$i"_perfectmatch.counts

cat s_"$i".sam | cut -f 3 | cat /dev/stdin japonicum_W.list | sort | uniq -c | awk '{print $2, $1-1}' > s_"$i".counts

done
