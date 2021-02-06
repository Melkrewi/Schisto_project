# SpliceFinder_2.pl: pick longest transcript per "gene" (cluster of similar transcripts)

Transcript assemblies will often have multiple isoforms of the same gene, which makes downstream analyses trickier. This programs makes clusters of transcripts with significant similarity in sequence, and selects only the longest.

## Approach

We take the following steps:
* use blat to find similar (<1% mismatch) stretches longer than 100bps between different transcripts.
* cluster transcripts that have similarity. Two transcript can be in the same cluster without being similar to each other, if they both show similarity to a third transcript (and so on and so forth).
* pick the longest transcript per cluster.

## Usage

The perl script is at:
```
[here](https://github.com/Melkrewi/Schisto_project/blob/main/Scripts/SpliceFinder_2.pl).
```

Usage: 

```
perl SpliceFinder_2.pl transcriptome.fa
```

Make sure to load module blat.

Right now this considers that transcripts that have mapping scores >100 with less that 1% divergence are the same. 

To change this, edit the BLAT running command at the beginning:
```
system "blat -t=dnax -q=dnax -minScore=50 $transcriptome $transcriptome /dev/stdout | awk '(\$10 != \$14)' | awk '(\$1>100 && (\$2/(\$1+\$2+0.00000001))<0.01)' > $transcriptome.blat";
```

NB: ignore the comment "#and sorted by Tname!!! sort -k 14!!!".
