# Schisto_project
Supplementary Code for Moldovan & Elkrewi et al. 

This repository included all the scripts and commands used in the analysis for Moldovan & Elkrewi et al. If anything is missing or not clear, please do not hesitate to reach out to us, and we will do out best to fix the issue or clarify.

Below is a rough guide to the content of each folder:

## Kmer analysis 
This folder includes a [flowchart](https://github.com/Melkrewi/Schisto_project/blob/Revised/Kmer_analysis/Kmer_pipeline.pdf) that explains the generic k-mer pipeline we implemented and used to detect and assemble W-transcripts from male and female DNA and RNA sequencing data. It also includes the list of libraries used for the kmer analysis in both species, [S. mansoni](https://github.com/Melkrewi/Schisto_project/blob/Revised/Kmer_analysis/Sman_list_of_libraries.txt) and [S. japonicum](https://github.com/Melkrewi/Schisto_project/blob/Revised/Kmer_analysis/Sjap_list_of_libraries.txt), and the implementation of the kmer pipeline with those libraries. In addition to that, the config files and the commands used to assemble the output of the kmer pipeline can be found there.

## Filtering_the_W_candidates
This folder has the steps we followed to filter the output of the kmer pipeline. It has two flowcharts explaining the general approach for each of the two species and the scripts used in the process.

## Identifying_the_Z_candidates_Sjap
The script for identifying and generating a fasta file with the the S. japonicum Z-candidates from the male transcriptome we assembled as described in the [Transcriptome_Assemblies/Male_Sjap_transcriptome](https://github.com/Melkrewi/Schisto_project/tree/Revised/Transcriptome_Assemblies/Male_Sjap_transcriptome) folder.
## Strata Identification


Supplementary Code 4: Strata Identification
Supplementary Code 5: A description of the process we followed to perform the FST analysis, from identifying the sex of the Miracidia samples to calculating FST
Supplementary Code 6: Estimating the Rates of Evolution of ZW homologs in S. mansoni
Supplementary Code 7: Estimating the Rates of Evolution of ZW homologs in S. japonicum
Supplementary Code 8: S. mansoni Transcriptome Curation for OrthoFinder
Supplementary Code 9: S. japonicum Transcriptome Curation for OrthoFinder
Supplementary Code 10: Running OrthoFinder
Supplementary Code 11: S. mansoni transcriptome curation for Kallisto
Supplementary Code 12: S. japonicum transcriptome curation for Kallisto
Supplementary Code 13: Running Kallisto S. mansoni
Supplementary Code 14: Running Kallisto S. japonicum
