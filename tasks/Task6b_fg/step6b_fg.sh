
# !/bin/bash

# Workflow dependency variables- only the ones required for this step
# The path to the required module
mybwa="/dependencies/bwa"
mysamtools="/dependencies/samtools-1.9/samtools"

# The input files
aws s3 cp s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.fasta.gz /genome/references/Homo_sapiens_assembly38.fasta.gz
gunzip /genome/references/Homo_sapiens_assembly38.fasta.gz
aws s3 cp s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.fasta.amb /genome/references/Homo_sapiens_assembly38.fasta.amb
aws s3 cp s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.fasta.ann /genome/references/Homo_sapiens_assembly38.fasta.ann
aws s3 cp s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.fasta.bwt /genome/references/Homo_sapiens_assembly38.fasta.bwt
aws s3 cp s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.fasta.pac /genome/references/Homo_sapiens_assembly38.fasta.pac
aws s3 cp s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.fasta.sa /genome/references/Homo_sapiens_assembly38.fasta.sa
myfasta="/genome/references/Homo_sapiens_assembly38.fasta"
myR1=$MYR1
myR2=$MYR2

# Setup for the output
samplelabel=$SAMPLELABEL
outdir="/genome/output"
mysamplebase=$outdir"/"$samplelabel

# Run the modules
cd $mybwa
./bwa mem \
     -aM \
     -t 2 \
     $myfasta \
     $myR1 $myR2 \
     | samtools view -bS > $mysamplebase.bam

# Write output to s3 bucket
aws s3 cp $mysamplebase.bam s3://<yourS3bucket>/output_fg/$samplelabel.bam