## Description of the files:
Kmer_pipeline.pdf: the flow chart of the kmer analysis process

Sman_list_of_libraries.txt: the list of the public genomic/RNA-seq libraries used in the (S. mansoni) kmer analysis

Sjap_list_of_libraries.txt: the list of the public genomic/RNA-seq libraries used in the (S. japonicum) kmer analysis

S_man_kmer.sh: the shell script for the S. mansoni kmer analysis implemented using the BBmap package

S_jap_kmer.sh: the shell script for the S. japonicum kmer analysis implemented using the BBmap package

soapconfig_Smansoni.txt: the config file for SOAPdenovo-trans (S. mansoni)

SOAPdenovo_trans_Sman.sh: the script to run SOAPdenovo-trans (S. mansoni)

soapconfig_Sjaponicum.txt: the config file for SOAPdenovo-trans (S. japonicum)

SOAPdenovo_trans_Sjap.sh: the script to run SOAPdenovo-trans (S. japonicum)

## Note 

The read libraries for both species were trimmed using Trimmomatic, except (SRR1421523 and SRR1421524) due to human error. However, we check that it did not affect the results afterwards. 
