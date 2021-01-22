for file in ~/*nt_cleanali.fasta #TranslatorX output

do

perl parseFastaIntoAXT.pl ${file}
~/KaKs_Calculator2.0/src/KaKs_Calculator -i ${file}.axt -o ${file}.kaks -m NG -m YN

done
