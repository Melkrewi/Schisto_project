#!/usr/bin/perl

my $list = $ARGV[0];
open (INPUT, "$list") or die "can't find $input";

while ($run = <INPUT>) 
    {
    chomp $run;
    print "$run\n";

### 1. Download fastq files
    #first check if the Kallisto folder already exists
    $filename = "KalFiles/$run";
    if (-e $filename)
        {
        print "$filename exists\n";
        }    
    else
        {
        #download only the first 30 million reads of each file so that we don't wait forever when there are huge ones
        system "fastq-dump --split-files --skip-technical $run";

### 2. Run Kallisto
        #check if XXX_2 exists
        $filename2="$run\_2.fastq";
        if (-e $filename2)
            {

            #if yes
            system "kallisto quant -t 16 -i ~/path-to-mansoni-kallisto-output/transcripts.idx -o KalFiles/$run -b 100 $run\_1.fastq $run\_2.fastq";
            }
        else
            {

            #if no
            print "$run is single-end\n";
            system "kallisto quant -t 16 -i ~/path-to-mansoni-kallisto-output/transcripts.idx -o KalFiles/$run -b 100 --single -l 400 -s 40 $run\_1.fastq";
            }

### 3. remove file
        system "rm $run\_1.fastq $run\_2.fastq";
        }
    }

