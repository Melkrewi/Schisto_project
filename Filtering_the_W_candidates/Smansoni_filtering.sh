#removing transcripts < 200bp
module load fafilter
srun faFilter -minSize=200  TranscriptAssembly.scafSeq mansoni_200.fasta

#Bowtie2 for counting perfect matches

module load java
module load bowtie2/2.3.4.1

srun bowtie2-build mansoni_200.fasta transcripts_w

srun bowtie2 -p 8 --no-unal --no-hd --no-sq -x transcripts_w -U ERR562990_1.fastq -S female_1.sam

srun bowtie2 -p 8 --no-unal --no-hd --no-sq -x transcripts_w -U ERR562989_1.fastq -S male_1.sam

awk '($6=="100M")' female_1.sam | grep 'NM:i:0' > female_1_perfectmatch.sam

awk '($6=="100M")' male_1.sam | grep 'NM:i:0' > male_1_perfectmatch.sam

grep '>' mansoni_200.fasta | perl -pi -e 's/>//gi' | perl -pi -e 's/ .*//gi' > transcripts.list

cat female_1_perfectmatch.sam | cut -f 3 | cat /dev/stdin transcripts..list | sort | uniq -c | awk '{print $2, $1-1}' > female_1_perfectmatch.counts

cat male_1_perfectmatch.sam | cut -f 3 | cat /dev/stdin transcripts.list | sort | uniq -c | awk '{print $2, $1-1}' > male_1_perfectmatch.counts
