# !/bin/bash

# Workflow dependency variables- only the ones required for this step
# The path to the required module
mybwa="/dependencies/bwa"

aws s3 cp s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.fasta.gz /genome/references/Homo_sapiens_assembly38.fasta.gz
gunzip /genome/references/Homo_sapiens_assembly38.fasta.gz
myfasta="/genome/references/Homo_sapiens_assembly38.fasta"

# The indexing step: used to compress the reference genome data
cd $mybwa
./bwa index $myfasta

# Write the references files to the s3 bucket
aws s3 cp /genome/references/Homo_sapiens_assembly38.fasta.amb s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.fasta.amb
aws s3 cp /genome/references/Homo_sapiens_assembly38.fasta.ann s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.fasta.ann
aws s3 cp /genome/references/Homo_sapiens_assembly38.fasta.bwt s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.fasta.bwt
aws s3 cp /genome/references/Homo_sapiens_assembly38.fasta.pac s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.fasta.pac
aws s3 cp /genome/references/Homo_sapiens_assembly38.fasta.sa s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.fasta.sa 