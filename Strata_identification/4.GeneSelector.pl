#!/usr/bin/perl

print "input are: a list of coordinates to exclude ($start $space $end), and a CDS file ($genename $chrom $start $end)";
print "usage: perl 4.GeneSelector.pl InputFile3_windows-to-exclude.csv InputFile4_mansoni-gene-coordinates.cnv\n";

my $input = $ARGV[0];
my $ensembl = $ARGV[1];
open (INPUT, "$input"); 
open (GENES, "$ensembl");
open (RESULTS, ">>$ensembl.Windows.txt");

while ($line = <INPUT>) {
    push (@windows, $line);
    }

while ($gline = <GENES>)
     {
    chomp $gline;
    chomp $gline;
    $gline =~ s/\n//g;
    ($gene, $chrom, $start, $end)=split(/\t/, $gline);
    if ($gene ne "Gene_ID")
        {
        foreach $window (@windows)
            {
            ($winchrom, $winstart, $winend)=split(/\t/, $window);
            if ($chrom eq $winchrom)
                {
                if (($start>$winstart && $start<$winend) || ($end>$winstart && $end<$winend) || ($start<$winstart && $end>$winend))
                    {
                    print RESULTS "$gline\n";
                    }
                else 
                    {
                    
                    }
                }
            }
        }
    else {}
    }

