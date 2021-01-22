module load muscle

module load gblocks/0.91b

for file in ~/*_final_cds.fasta 

do 

perl ~/translatorx_vLocal.pl -i ${file} -o ${file}.fa.tx -t T -g "-s"

done
