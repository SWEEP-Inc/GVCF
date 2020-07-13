# !/bin/bash

# Set up the dependency variables 
mysamtools="/dependencies/samtools-1.9/samtools"

# The input file
aws s3 cp s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.fasta.gz /genome/references/Homo_sapiens_assembly38.fasta.gz
gunzip /genome/references/Homo_sapiens_assembly38.fasta.gz
myfasta="/genome/references/Homo_sapiens_assembly38.fasta"

# Run the module
$mysamtools faidx $myfasta

aws s3 cp /genome/references/Homo_sapiens_assembly38.fasta.fai s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.fasta.fai