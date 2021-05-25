#!/usr/bin/perl

my $input = $ARGV[0];

system "sort -k 10 $input > $input.sorted";
open (INPUT, "$input.sorted");

open (RESULTS1, ">$input.besthit");

#print RESULTS1 "Qname\tTname\tsimilarity\talignL\tmismatch\tgaps\tQstart\tQend\tTstart\tTend\tmatch\tbitscore\n";

$name0="";
$score0=0;
$line0="";

while ($line = <INPUT>) {
($match, $mis, $rep, $N, $Qgapc, $Qgapb, $Tgapc, $Tgapb, $strand, $Qname, $Qsize, $Qstart, $Qend, $Tname, $Tsize, $Tstart, $Tend, $blockc, $blocksize, $qstarts, $tstarts)=split(/\t/, $line);
    
    if ($Qname eq $name0)
        {
        if ($match > $score0)
            {
            $name0=$Qname;
            $score0=$match;
            $line0=$line;
            }
        else
            {
            }

        }
    else
        {
        print RESULTS1 $line0;
        $name0=$Qname;
                $score0=$match;
                $line0=$line;

        }
        
    
    }

print RESULTS1 $line0;

close (RESULTS1);
close (INPUT);



#system "perl -pi -e 's/^[^0-9].*//gi' $input.besthit";
#system "perl -pi -e 's/1match/match/gi' $input.besthit";
system "perl -pi -e 's/^\n//gi' $input.besthit";


system "sort -k 14 $input.besthit > $input.besthit.sorted2";
open (INPUT2, "$input.besthit.sorted2");

open (RESULTS2, ">$input.bestreciprocal");

#print RESULTS2 "Qname\tTname\tsimilarity\talignL\tmismatch\tgaps\tQstart\tQend\tTstart\tTend\tmatch\tbitscore\n";

$name0="";
$score0=0;
$line0="";

while ($line = <INPUT2>) {
    ($match, $mis, $rep, $N, $Qgapc, $Qgapb, $Tgapc, $Tgapb, $strand, $Qname, $Qsize, $Qstart, $Qend, $Tname, $Tsize, $Tstart, $Tend, $blockc, $blocksize, $qstarts, $tstarts)=split(/\t/, $line);
    
    if ($Tname eq $name0)
        {
        if ($match > $score0)
            {
            $name0=$Tname;
            $score0=$match;
            $line0=$line;
            }
        else
            {
            }

        }
    else
        {
        print RESULTS2 $line0;
        $name0=$Tname;
                $score0=$match;
                $line0=$line;

        }
        
    
    }

print RESULTS2 $line0;

system "rm $input.sorted $input.besthit.sorted2 $input.besthit";
system "perl -pi -e 's/^[^0-9].*//gi' $input.bestreciprocal";
system "perl -pi -e 's/1match/match/gi' $input.bestreciprocal";
system "perl -pi -e 's/^\n//gi' $input.bestreciprocal";


close (RESULTS2);
close (INPUT2);

