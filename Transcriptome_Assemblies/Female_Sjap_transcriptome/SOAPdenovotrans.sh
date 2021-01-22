module load SOAPdenovoTrans

SOAPdenovo-Trans-127mer all -s soapconfig_trans.txt -K 65 -o TranscriptAssemblyK65 -p 16 1> TranscriptAssemblyK65.stdout 2> TranscriptAssemblyK65.stderr
