#!/usr/bin/perl

#programs to load: blat

#this program is meant to find groups of spliceforms from the same gene
#and list the longest transcript for each cluster

############################Part 1: produce Blat file

my $transcriptome = $ARGV[0];

system "blat -t=dnax -q=dnax -minScore=50 $transcriptome $transcriptome /dev/stdout | awk '(\$10 != \$14)' | awk '(\$1>100 && (\$2/(\$1+\$2+0.00000001))<0.01)' > $transcriptome.blat";

############################Part 2: find short alternative splicing forms

#the input file should be a blat file: srun blat TranscriptAssembly_500.scafSeq TranscriptAssembly_500.scafSeq /dev/stdout | awk '($10 != $14)' | awk '($1>100 && ($2/($1+$2+0.00000001))<0.01)' > Transcripts500_versus_Transcripts500.blat

#match	mismatch	rep	Ns	Qgapcount	Qgapbases	Tgapcount	Tgapbases	strand	Qname	Qsize	Qstart	Qend	Tname	Tsize	Tstart	Tenblockcount	blockSizes	qStarts	tStarts
#and sorted by Tname!!! sort -k 14!!!

#usage: perl SpliceformFinder.pl inputfile

#option 1: use previous blat
my $input = "$transcriptome.blat";


open (INPUT, "$input"); 
open (RESULTS, ">$input.good");
open (RESULTS2, ">$input.bad");

my @big = "";

while ($line = <INPUT>) 
	{
	next if $. < 2; # Skip first line
	($blatscore, $mismatch, $rep, $Ns, $Qgapcount, $Qgapbases, $Tgapcount, $Tgapbases, $strand, $Qname, $Qsize, $Qstart, $Qend, $Tname, $Tsize, $Tstart, $Tend, $blockcount, $blockSizes, $qStarts, $tStarts)=split(/\t/, $line);

	#let's store the lengths of each gene
	$length{$Qname} = $Qsize;
	$length{$Tname} = $Tsize;

	$current = join(" ", $Qname, $Tname);
	
	$counter=0;
	$arraycounter=0;
	
	#let's check if the two genes are already in any of the arrays stashed in @big
	foreach $small (@big)
		{
		@small = split(" ", $small);
		foreach $gene (@small)
			{
			#if one of the arrays already contains one of the genes, we want to place it in a temporary array (and remove it from @big)
			if ($gene eq $Qname || $gene eq @Tname)
				{
				
				push (@temp, $current);
				push (@temp, $small);

#print "Temp is : @temp\n";
#print "Remove is: $big[$arraycounter]\n";
				#remove from big
				undef $big[$arraycounter];
				
				#make a note that the genes were matched to a previously existing array
				$counter=$counter+1;

				}

			}

		$arraycounter=$arraycounter+1;		
		#end outer foreach
		}
	
	#if the two genes were not found in previous arrays of @big, let's add them
	if ($counter==0)
		{
		push (@big, $current);
		
		}
	
	#if either of the two genes were found 
	else 
		{
		#make temp $variable and add to big
		$temp = join (" ", @temp);
		#before adding to big, let's remove elements that show up multime times
		@temp2 = split(" ", $temp);
		my @unique = do { my %seen; grep { !$seen{$_}++ } @temp2 };
		$temp3 = join (" ", @unique);
		
		#add the temporary variable to @big
		push (@big, $temp3);
		$temp = "";
		@temp = ();
		@temp2 = ();
		@unique = ();
		$temp3 = "";
		}

	#end while
	}

#remove undefined lines
@big = grep defined, @big;


####
#now let's test which of the splice forms is the longest

foreach $small (@big)
	{
	@small = split(" ", $small);
	$longest = 0;
	$best = "";
	@bad = ();

	foreach $gene (@small)
		{
		if ($length{$gene}>$longest)
			{
			#former best gene is now sent to bad list
			print RESULTS2 "$best\n";
			$best = $gene;
			$longest = $length{$gene};
			}
		else
			{
			#this gene is bad
			print RESULTS2 "$gene\n";
			#push (@bad, $gene);

			}

		}

	print RESULTS "$best\n";
	#$superbad = join ("\n", @bad);
	#print RESULTS2 "$superbad\n";

	}

close (RESULTS);
close (RESULTS2);

system "perl -pi -e 's/^\n//gi' $input.good";
system "perl -pi -e 's/^\n//gi' $input.bad";

#######################Part 3: Produce new transcriptome




###first make list of contigs to remove
my $removables = "$input.bad";
open (REMOV, "$removables") or die "can't find list of contigs to remove at $removables";

while ($remove=<REMOV>)
	{
	chomp $remove;
	push @redflag, $remove; 
	}

open (INPUT, "$transcriptome") or die "can't find $transcriptome";
open (RESULTS3, ">$transcriptome.long");

$/ = ">";

while ($line=<INPUT>)
	{
	next if $. < 2; # Skip first line
	chomp $line;

	#get fasta name and sequence
	(@dnas)=split ("\n", $line);
	$definition=$dnas[0];
	@names = split(" ", $definition);
	$name = $names[0];
	shift @dnas;
	$sequence=join ("", @dnas);
	
	#check if the sequence is a bad one
	#let's use a counter, and add 1 to it if it matches a bad name
	$counter=0;
	foreach (@redflag)
		{
		chomp $_;
		if ($name eq $_)
			{
			$counter = $counter+1;
			#print "$name is bad because it matched $_\n";
			}
		else
			{
			#print "$name did not match $_\n";

			}
		}
	#Now let's keep only sequences that have a counter of 0
	if ($counter == 0)
		{
		print RESULTS3 ">$line";
		}
	else 	
		{
		print "$name was removed (counter was $counter)\n";
		}

	}

system "perl -pi -e 's/>>//gi' $transcriptome.long";
system "perl -pi -e 's/^scaffold/>scaffold/gi' $transcriptome.long";


