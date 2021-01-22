#remove transcripts shorter than 200bp
module load fafilter

srun faFilter -minSize=200  TranscriptAssembly.scafSeq japonicum_200.fasta

#Bowtie2 counting perfect matches

module load java

module load bowtie2/2.3.4.1

module load soap/coverage

srun bowtie2-build japonicum_200.fasta transcripts_w

srun bowtie2 -p 8 --no-unal --no-hd --no-sq -x transcripts_w -U SRR5054672_1.fastq -S mixed_1.sam

srun bowtie2 -p 8 --no-unal --no-hd --no-sq -x transcripts_w -U SRR5054673_1.fastq -S mixed_2.sam

srun bowtie2 -p 8 --no-unal --no-hd --no-sq -x transcripts_w -U SRR5054701_1.fastq -S mixed_3.sam

srun bowtie2 -p 8 --no-unal --no-hd --no-sq -x transcripts_w -U SRR5054524_1.fastq -S male_1.sam

srun bowtie2 -p 8 --no-unal --no-hd --no-sq -x transcripts_w -U SRR5054649_1.fastq -S male_2.sam

srun bowtie2 -p 8 --no-unal --no-hd --no-sq -x transcripts_w -U SRR5054671_1.fastq -S male_3.sam

srun bowtie2 -p 8 --no-unal --no-hd --no-sq -x transcripts_w -U SRR5054674_1.fastq -S male_4.sam


awk '($6=="100M")' mixed_1.sam | grep 'NM:i:0' > mixed_1_perfectmatch.sam

awk '($6=="100M")' mixed_2.sam | grep 'NM:i:0' > mixed_2_perfectmatch.sam

awk '($6=="100M")' mixed_3.sam | grep 'NM:i:0' > mixed_3_perfectmatch.sam

awk '($6=="100M")' male_1.sam | grep 'NM:i:0' > male_1_perfectmatch.sam

awk '($6=="100M")' male_2.sam | grep 'NM:i:0' > male_2_perfectmatch.sam

awk '($6=="100M")' male_3.sam | grep 'NM:i:0' > male_3_perfectmatch.sam

awk '($6=="100M")' male_4.sam | grep 'NM:i:0' > male_4_perfectmatch.sam

grep '>' japonicum_200.fasta | perl -pi -e 's/>//gi' | perl -pi -e 's/ .*//gi' > transcripts.list

cat mixed_1_perfectmatch.sam | cut -f 3 | cat /dev/stdin transcripts.list | sort | uniq -c | awk '{print $2, $1-1}' > mixed_1_perfectmatch.counts

cat mixed_2_perfectmatch.sam | cut -f 3 | cat /dev/stdin transcripts.list | sort | uniq -c | awk '{print $2, $1-1}' > mixed_2_perfectmatch.counts

cat mixed_3_perfectmatch.sam | cut -f 3 | cat /dev/stdin transcripts.list | sort | uniq -c | awk '{print $2, $1-1}' > mixed_3_perfectmatch.counts

cat male_1_perfectmatch.sam | cut -f 3 | cat /dev/stdin transcripts.list | sort | uniq -c | awk '{print $2, $1-1}' > male_1_perfectmatch.counts

cat male_2_perfectmatch.sam | cut -f 3 | cat /dev/stdin transcripts.list | sort | uniq -c | awk '{print $2, $1-1}' > male_2_perfectmatch.counts

cat male_3_perfectmatch.sam | cut -f 3 | cat /dev/stdin transcripts.list | sort | uniq -c | awk '{print $2, $1-1}' > male_3_perfectmatch.counts

cat male_4_perfectmatch.sam | cut -f 3 | cat /dev/stdin transcripts.list | sort | uniq -c | awk '{print $2, $1-1}' > male_4_perfectmatch.counts
