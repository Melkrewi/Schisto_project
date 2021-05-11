############################################################
# Expression analysis with Kallisto #
############################################################

### Expression analysis in S. mansoni

1.kallisto_index_mans.sh
The curated S. mansoni transcriptome (Sup. Code 11) was indexed for subsequent Kallisto analysis.
*Input: curated S. mansoni transcriptome

2.slurm-script-for-siliconer.sh
Bash script for launching Siliconer perl script, and allowing to feed the table containing the list of libraries. It is shown  for 3.Siliconer_mans_SRR.pl, but was similarly applied for 4.Siliconer_mans_ERR.pl and 6.Siliconer_jap.pl. 
*Input: list of libraries "RUNlist.txt", a text file with a library number per line + corresponding siliconer perl script

3.Siliconer_mans_SRR.pl
Script allowing the automatized download and Kallisto analysis for a given list of libraries. 
If single-end reads, the fragment size should be adapted on the Kallisto command line! For mansoni SRR libraries used here: [-l 400 -s 40]
*Input: mansoni kallisto index + corresponding slurm-script-for-siliconer.sh 
 
4.Siliconer_mans_ERR.pl
Script allowing the automatized download and Kallisto analysis for a given list of libraries. 
If single-end reads, the fragment size should be adapted on the Kallisto command line! For mansoni ERR libraries used here: [-l 180 -s 20]
*Input: mansoni kallisto index + corresponding slurm-script-for-siliconer.sh

### Expression analysis in S. japonicum

5.kallisto_index_jap.sh
The curated S. japonicum transcriptome (Sup. Code 12) was indexed for subsequent Kallisto analysis.
*Input: curated S. japonicum transcriptome

6.Siliconer_jap.pl
Script allowing the automatized download and Kallisto analysis for a given list of libraries.
*Input: japonicum kallisto index + corresponding slurm-script-for-siliconer.sh
