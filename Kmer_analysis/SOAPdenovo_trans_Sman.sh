echo "### Step 1: Assembly of Candidates"
module load SOAPdenovoTrans

srun SOAPdenovo-Trans-31mer all -s soapconfig.txt -K 15 -o TranscriptAssembly -p 16 1> TranscriptAssembly.stdout 2> TranscriptAssembly.stderr
