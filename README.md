# Schisto_project
Supplementary Code for Moldovan & Elkrewi et al. 

This repository included all the scripts and commands used in the analysis for Moldovan & Elkrewi et al. If anything is missing or not clear, please do not hesitate to reach out to us, and we will do out best to fix the issue or clarify.

Below is a rough guide to the content of each folder:

## Kmer analysis 
This folder includes a [flowchart](https://github.com/Melkrewi/Schisto_project/blob/Revised/Kmer_analysis/Kmer_pipeline.pdf) that explains the generic k-mer pipeline we implemented and used to detect and assemble W-transcripts from male and female DNA and RNA sequencing data. It also includes the list of libraries used for the kmer analysis in both species, [S. mansoni](https://github.com/Melkrewi/Schisto_project/blob/Revised/Kmer_analysis/Sman_list_of_libraries.txt) and [S. japonicum](https://github.com/Melkrewi/Schisto_project/blob/Revised/Kmer_analysis/Sjap_list_of_libraries.txt), and the implementation of the kmer pipeline with those libraries. In addition to that, the config files and the commands used to assemble the output of the kmer pipeline can be found there.

## Filtering_the_W_candidates
This folder has the steps we followed to filter the output of the kmer pipeline. It has two flowcharts, [one for S. Mansoni](https://github.com/Melkrewi/Schisto_project/blob/Revised/Filtering_the_W_candidates/Mansoni_Filtering.pdf) and [one for S. japonicum](https://github.com/Melkrewi/Schisto_project/blob/Revised/Filtering_the_W_candidates/Japonicum_Filtering.pdf) explaining the general approach for each of the two species and the scripts used in the process.

## Identifying_the_Z_candidates_Sjap
The script for identifying and generating a fasta file with the the S. japonicum Z-candidates from the male transcriptome we assembled as described in the [Transcriptome_Assemblies/Male_Sjap_transcriptome](https://github.com/Melkrewi/Schisto_project/tree/Revised/Transcriptome_Assemblies/Male_Sjap_transcriptome) folder.
## Strata Identification


## Fst_Analysis

We downloaded whole genome sequencing data of [22 S. japonicum individual Miracidia samples (PRJNA650045)](https://github.com/Melkrewi/Schisto_project/blob/Revised/Fst_Analysis/Miracidia_samples.txt). The sex of the samples was not identified, so we used Bowtie2 (v2.3.4.1, --end-to-end --sensitive mode) to map the reads to the S. japonicum genome. The resulting SAM files were filtered to keep only uniquely mapped reads, and the genomic coverage for each scaffold was estimated from the filtered SAM files with SOAPcoverage (v2.7.7, http://soap.genomics.org.cn). We used the output to calculate the median Z:Autosomal genomic coverage for each of the samples based on the scaffold assignments from (Picard et al. 2018). Furthermore, we used bowtie2 (--no-unal --no-hd --no-sq) to map the forward reads of all the samples to our W-candidates and three randomly chosen Autosomal controls; we filtered for 0 edit distance “NM:i:0” to find the number of perfectly-matched reads. . We removed three of the samples due to low coverage, and the remaining 19 were identified as 11 males (Log2(Z:A)>0.9) and 8 females (Log2(Z:A)<0.75 and ratio of reads mapping to W versus autosomal controls > 100, Sup. Figure 4).
We used Bowtie2 to index the S. japonicum genome and map the genomic reads from the 19 libraries to it (--end-to-end --sensitive mode). The SAM files were converted to sorted BAM files using Samtools. We detected the genetic variants (SNPs) in the samples using the BCFtools mpileup function, filtered the output for minimum and maximum read coverage and mapping quality using VCFtools, and removed multi-allelic sites using BCFtools. The calculation of the per-site FST between males and females was performed using VCFtools, and the output was used to calculate the mean FST values between the male and female samples for each scaffold.

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
