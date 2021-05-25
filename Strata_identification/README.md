###############################################
# Strata Identification #
###############################################
 
### De novo determination of Z-specific regions in S. mansoni 

1.bowtie2_mansoni.sh script needs as inputs: male and female DNA reads + fasta file of the reference genome

2.soapcov_mansoni.sh script needs as inputs: sam outputs of script 1 + fasta file of the reference genome

3.Zregions_Smansoni.R script needs as inputs: InputFile1_Smansoni_SoapCov_By10kb_ForR_NewG.csv (i.e. modified output from script2) for the STEP1 + inputFile2_Zonly_10kb.txt (output of STEP1) for the STEP2 

4.GeneSelector.pl script needs as inputs: InputFile3_windows-to-exclude.csv + InputFile4_mansoni-gene-coordinates.csv 

### Inference of the location of  S. japonicum scaffolds along the S. mansoni Z-chromosome

5.blat.sh script needs as inputs: the CDS of S. mansoni as fasta file + the genome of S. japonicum as fasta file

6.besthitblat.pl script needs as inputs: the output of script 5, sorted by scaffold name (column 10)

7.blatreverse.pl script needs as inputs: the output of script 6, sorted by target name (column 14)

8.Figure1.R script needs as inputs: InputFile5_Smansoni_SoapCov_By10kb_ForR_NewG_onlyZW.csv + Dataset4_ZW_pairs_dNdS_with_strata_assignments_mansoni.csv + InputFile6_Sjaponicum_coverage_FST.csv + Dataset4_ZW_pairs_dNdS_with_strata_assignments_japonicum.csv + Dataset6_S_jap_Genome_Fst
