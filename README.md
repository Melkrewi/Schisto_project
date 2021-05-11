# Schisto_project
Supplementary Code for Moldovan & Elkrewi et al. 

This repository includes all the scripts and commands used in the analysis for Moldovan & Elkrewi et al. If anything is missing or not clear, please do not hesitate to reach out to us, and we will do out best to fix the issue or provide more details.

Below is a rough guide to the content of each folder:

## Kmer analysis 
This folder includes a [flowchart](https://github.com/Melkrewi/Schisto_project/blob/main/Kmer_analysis/Kmer_pipeline.pdf) that explains the generic k-mer pipeline we implemented and used to detect and assemble W-transcripts from male and female DNA and RNA sequencing data. It also includes the list of libraries used for the kmer analysis in both species, [S. mansoni](https://github.com/Melkrewi/Schisto_project/blob/main/Kmer_analysis/Sman_list_of_libraries.txt) and [S. japonicum](https://github.com/Melkrewi/Schisto_project/blob/main/Kmer_analysis/Sjap_list_of_libraries.txt), and the implementation of the kmer pipeline with those libraries. In addition to that, the config files and the commands used to assemble the output of the kmer pipeline can be found there.

## Filtering_the_W_candidates
This folder has the steps we followed to filter the output of the kmer pipeline. It has two flowcharts, [one for S. Mansoni](https://github.com/Melkrewi/Schisto_project/blob/main/Filtering_the_W_candidates/Mansoni_Filtering.pdf) and [one for S. japonicum](https://github.com/Melkrewi/Schisto_project/blob/main/Filtering_the_W_candidates/Japonicum_Filtering.pdf) explaining the general approach for each of the two species and the scripts used in the process.

## Identifying_the_Z_candidates_Sjap
The script for identifying and generating a fasta file with the the S. japonicum Z-candidates from the male transcriptome we assembled as described in the [Transcriptome_Assemblies/Male_Sjap_transcriptome](https://github.com/Melkrewi/Schisto_project/tree/main/Transcriptome_Assemblies/Male_Sjap_transcriptome) folder.
## Strata Identification


## Fst_Analysis

* We downloaded whole genome sequencing data of [22 S. japonicum individual Miracidia samples (PRJNA650045)](https://github.com/Melkrewi/Schisto_project/blob/main/Fst_Analysis/Miracidia_samples.txt). 

* The sex of the samples was not identified, so we used bowtie2 as in [Genomic_coverage.sh](https://github.com/Melkrewi/Schisto_project/blob/main/Fst_Analysis/Genomic_coverage.sh) to map the reads to the S. japonicum genome, filter the resulting SAM files to keep only uniquely mapped reads, and estimate the genomic coverage for each scaffold from the filtered SAM files. We used the output to calculate the median Z:Autosomal genomic coverage for each of the samples based on the scaffold assignments from (Picard et al. 2018). 
* We used bowtie2 as in [counting_perfect_matches_to_Wcandidates.sh](https://github.com/Melkrewi/Schisto_project/blob/main/Fst_Analysis/counting_perfect_matches_to_Wcandidates.sh) to map the forward reads of all the samples to our W-candidates and three randomly chosen Autosomal controls. We filtered for 0 edit distance “NM:i:0” to find the number of perfectly-matched reads. We removed three of the samples due to low coverage, and the remaining 19 were identified as 11 males (Log2(Z:A)>0.9) and 8 females (Log2(Z:A)<0.75 and ratio of reads mapping to W versus autosomal controls > 100).
* The SAM files for the 19 libraries generated using Bowtie2 in the first step were [converted to sorted BAM](https://github.com/Melkrewi/Schisto_project/blob/main/Fst_Analysis/SAM_to_sorted_BAM.sh) files using Samtools. 
* We detected the genetic variants (SNPs) in the samples using the BCFtools mpileup function, filtered the output for minimum and maximum read coverage and mapping quality using VCFtools, and removed multi-allelic sites using BCFtools, then estimated the per-site FST between males and females using VCFtoolsas using in [SNP_calling.sh](https://github.com/Melkrewi/Schisto_project/blob/main/Fst_Analysis/SNP_calling.sh). 
* The calculation of the per-site FST between males and females was performed using VCFtools, and the output was used to calculate the mean FST values between the male and female samples for each scaffold using [meanFst_per_scaffold.r](https://github.com/Melkrewi/Schisto_project/blob/main/Fst_Analysis/meanFst_per_scaffold.r).

## dNdS
* The coding sequences of W-candidates of both species (and of their closest homolog in S. japonicum) were obtained with the command-line version of Genewise, using the protein sequence of the closest S. mansoni homolog as input. The script for S. mansoni can be found in [Genewise_Sman/genewise.sh](https://github.com/Melkrewi/Schisto_project/blob/main/dNdS/Genewise_Sman/genewise.sh) along with the [list of homologs](https://github.com/Melkrewi/Schisto_project/blob/Revised/dNdS/Genewise_Sman/names_for_genewise.txt), and for S. japoncium in [Genewise_Sjap/genewise.sh](https://github.com/Melkrewi/Schisto_project/tree/main/dNdS/Genewise_Sjap/genewise.sh) along with the [list of homologs](https://github.com/Melkrewi/Schisto_project/blob/Revised/dNdS/Genewise_Sjap/names_for_genewise.txt).

* The coding sequences of W-candidates and their closest homolog (within the same species) were aligned with the TranslatorX package with the “gblocks” option to filter out unreliable sections of the alignment using [this script](https://github.com/Melkrewi/Schisto_project/blob/Revised/dNdS/TranslatorX.sh)
* The dN and dS values were obtained with KaKs_calculator2.0 using [this script](https://github.com/Melkrewi/Schisto_project/blob/main/dNdS/KaKs_Calculator.sh).

## Transcriptome_curation
This folder includes a [flowchart](https://github.com/Melkrewi/Schisto_project/blob/main/Transcriptome_curation/Transcriptome%20curation.pdf) that describes the process we followed to curate the transcriptomes for OrthoFinder and Kallisto. Below is a brief description of the same process:
* We used the in-house script [Splicefinder.pl](https://github.com/Melkrewi/Schisto_project/blob/Revised/Scripts/SpliceFinder_2.pl) to remove all the isoforms from the published transcriptomes of both species. 
* We mapped our set of W-candidates and their homologs to their respective transcriptomes and removed any transcripts with matches > 100 bp and less than 5% divergence, and then we added our candidate set to the transcriptomes using the following scripts (the lists of the removed transcripts are provided in the same folder):
  * [S. mansoni Orthofinder](https://github.com/Melkrewi/Schisto_project/blob/main/Transcriptome_curation/Sman_OrthoFinder/Trans_curation_for_OrthoFinder.sh)
  * [s. japonicum Orthofinder](https://github.com/Melkrewi/Schisto_project/blob/main/Transcriptome_curation/Sjap_OrthoFinder/Trans_curation_for_OrthoFinder.sh)
  * [S. mansoni Kallisto](https://github.com/Melkrewi/Schisto_project/blob/main/Transcriptome_curation/Sman_Kallisto/Trans_curation_for_Kallisto.sh)
  * [S. japonicum Kallisto](https://github.com/Melkrewi/Schisto_project/blob/main/Transcriptome_curation/Sjap_Kallisto/Trans_curation_for_Kallisto.sh)

## OrthoFinder
* We downloaded the coding sequences of Clonorchis sinensis from the WormBase Parasite database and used it as an outgroup. 
* We used an in-house perl script [GetLongestAA_v1_July2020.pl](https://github.com/Melkrewi/Schisto_project/blob/main/Scripts/GetLongestAA_v1_July2020.pl) to perform 6-frame translation of all the transcripts and retain only the longest isoforms. 
* Orthofinder was then run using the three transcriptomes to assign proteins to clusters of homologs (“orthogroups”) using [this script](https://github.com/Melkrewi/Schisto_project/blob/main/OrthoFinder/Running_OrthoFinder.sh).

## Kallisto

## Transcriptome_Assemblies
This folder has the steps we followed to assemble: 
* The female transcriptome used to improve assembly of the S. japonicum W-candidates. The libararies we used can be found in [libraries.txt](https://github.com/Melkrewi/Schisto_project/blob/main/Transcriptome_Assemblies/Female_Sjap_transcriptome/libraries.txt), along with [the config file](https://github.com/Melkrewi/Schisto_project/blob/main/Transcriptome_Assemblies/Female_Sjap_transcriptome/soapconfig_trans.txt) and [the assembly script](https://github.com/Melkrewi/Schisto_project/blob/main/Transcriptome_Assemblies/Female_Sjap_transcriptome/SOAPdenovotrans.sh).

* The male transcriptome used to recover the Z-candidates. We trimmed the male reads (SRR8175618) with [the Trimmomatic package](https://github.com/Melkrewi/Schisto_project/blob/main/Transcriptome_Assemblies/Male_Sjap_transcriptome/Trimmomatic.sh) and then assembled them using [Trinity](https://github.com/Melkrewi/Schisto_project/blob/main/Transcriptome_Assemblies/Male_Sjap_transcriptome/Assembly_Trinity.sh) followed by [Cap3](https://github.com/Melkrewi/Schisto_project/blob/main/Transcriptome_Assemblies/Male_Sjap_transcriptome/Assembly_Cap3.sh).

