# Scripts to get the longest ORF per transcript and the corresponding AA sequence

*Last update: October 9 2020. Fixed bug in GetLongestCDS_v1_July2020.pl: when a codon had an "N", it was transformed to "X", instead of "NNN".*

In both case, the only input required is a fasta with transcripts. 

The output will be another fasta file (endingin in .aa or .cds) containing the longest ORF or corresponding protein sequence for each transcript.

ORFs/proteins can start with any codon/AA (i.e. we do not require the CDS to start with "ATG"). 

## Get longest protein sequence per transcript

The script is [here](https://github.com/Melkrewi/Schisto_project/blob/main/Scripts/GetLongestAA_v1_July2020.pl).

Usage:
```
perl GetLongestAA_v1_July2020.pl transcripts.fasta 
```

Output:
```
transcripts.fasta.aa
```

## Get longest ORF per transcript

The script is [here](https://github.com/Melkrewi/Schisto_project/blob/main/Scripts/GetLongestCDS_v2_October2020.pl).

Usage:
```
perl scripts_GetLongestCDS_v2_October2020.pl transcripts.fasta 
```

Output:
```
transcripts.fasta.cds
```

