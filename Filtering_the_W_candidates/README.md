## A brief description of the files used to filter the output of the Kmer pipeline:

Mansoni_filtering.pdf: the flow chart of the filtering process in S. mansoni

Japonicum_Filtering.pdf: the flow chart of the filtering process in S. japonicum

Smansoni_filtering.sh: the script used to remove transcripts < 200 bp and map the female (ERR562990) and male (ERR562989) genomic reads to the output of the Kmer pipeline. All transcripts that had less than 20 perfectly matching female reads and a ratio of (male/(male+female)) perfect matches of more than 0.1 were removed.

Sjaponicum_filtering_Step1.sh: the script used to remove transcripts < 200 bp and then map a set of four male only genomic libraries (SRR5054524, SRR5054649, SRR5054671, SRR5054674) and three mixed (males+females) libraries (SRR5054672, SRR5054673, SRR5054701) to the output of the Kmer pipeline. All transcripts with a sum of perfect matches from the mixed genomic libraries of less than 20 reads and a ratio of (male/(male+mixed)) of less than 0.1 were removed.

Sjaponicum_candidates_reassembly.sh: the script we used to improve the assembly of the S. japonicum candidates using the female assembly (description in the Transcriptome_Assemblies folder). SpliceFinder.pl can be found on the main folder.

Sjaponicum_filtering_Step2.sh: Repeating Step1 on the improved assembly of candidates
