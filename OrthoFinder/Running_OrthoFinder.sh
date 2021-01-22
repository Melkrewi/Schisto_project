#translate the transcriptomes
perl GetLongestAA_v1_July2020.pl schistosoma_japonicum_plus_ZW_orthofinder_17_11_2020.fasta

perl GetLongestAA_v1_July2020.pl schistosoma_Mansoni_plus_ZW_orthofinder_09_11_2020.fasta

perl GetLongestAA_v1_July2020.pl  clonorchis_sinensis.PRJNA386618.WBPS14.CDS_transcripts.fa

#place all of the transcriptomes in one file (schistosoma) and run OrthoFinder
~/orthofinder/OrthoFinder/orthofinder -f ~/schistosoma
