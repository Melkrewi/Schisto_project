Supplementary Code 6: CNV analysis with control-FREEC

1/ Read mapping to S. japonicum genome

*Methods: described in Picard et al., Elife, 2018 (doi: 10.7554/eLife.35684)

*Input(s):

•	DNA libraries: SRR6841388 for females and SRR6841389 for males

•	Reference genome: schistosoma_japonicum.PRJEA34885.WBPS9.genomic.fa

2/ CNV prediction with control-FREEC

*Script(s): 2.controlFREEC.sh 3.controlFREEC.config 

*Input(s):

•	modified output from bowtie 2: only mapped reads and sorted sam

•	a file with the S. japonicum length ("jap_scaff_length")

•	control-FREEC output

3/ Significance assessment

*Script(s) provided with the controlFREEC-11.6 package: 4.assess_significance.R 

*Input(s): 

•	control-FREEC output

4/ Identification of genes overlapping deletions

*Script(s): 5.gene-selector.pl 

*Input(s):

•	selected CNV from the significance assessment: wilcoxon p-value < 0.05 and “loss” tag: corresponds to the three first columns of the sup. dataset 16 “CNVtable_onlysign_loss_controlFREECoutput.csv” (one table per window size)

•	“japonicum-gene-coordinates.csv” corresponds to a 4 column file (1:Gene name, 2:Scaffold name, 3:Gene start, 4:Gene end) generated from schistosoma_japonicum.PRJEA34885.WBPS9.canonical_geneset.gtf

5/ Identification of one-to-one orthologs between S. japonicum and S. mansoni

*Script(s): 6.blat_1to1.sh 7.bestreciprocalhit.pl 

*Input(s):

•	schistosoma_mansoni.PRJEA36577.WBPS14.CDS_transcripts.fa
•	schistosoma_japonicum.PRJEA34885.WBPS9.genomic.fa

