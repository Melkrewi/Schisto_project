#Using Cap3 to further assemble the output of Trinity

module load  cap3/02-10-15

cap3 Trinity.fasta -h 80 -o 40

cat Trinity.fasta.cap.contigs Trinity.fasta.cap.singlets > Trinity_cap3.fasta
