#!/usr/bin/perl
print "finds all genes in a list of window coordinates\n";
print "input is: list of coordinates (start, space, end) and CDSfile (genename,chrom,start,end)";
print "usage: perl GeneFinder.pl CNVcoords.txt CDSfile\n";

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
