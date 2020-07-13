#!/bin/bash

# Setting up the dependencies and loading the input files
aws s3 cp s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.fasta.gz /genome/references/Homo_sapiens_assembly38.fasta.gz
gunzip /genome/references/Homo_sapiens_assembly38.fasta.gz
aws s3 cp s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.fasta.fai /genome/references/Homo_sapiens_assembly38.fasta.fai
aws s3 cp s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.dict /genome/references/Homo_sapiens_assembly38.dict
myfasta="/genome/references/Homo_sapiens_assembly38.fasta"
mygatk="/dependencies/gatk-4.1.2.0"

outdir="/genome/output"
mysamplebase=$outdir"/"$SAMPLELABEL

aws s3 cp s3://<yourS3bucket>/output_fg/$SAMPLELABEL-sort-rg-dedup.bam $mysamplebase-sort-rg-dedup.bam
aws s3 cp s3://<yourS3bucket>/output_fg/$SAMPLELABEL-recal-table.txt $mysamplebase-recal-table.txt

# Running the module
cd $mygatk
./gatk ApplyBQSR \
     -R $myfasta \
     -I $mysamplebase"-sort-rg-dedup.bam" \
     -bqsr $mysamplebase"-recal-table.txt" \
     -O  $mysamplebase"-GATK.bam"

# Writing the output to s3
aws s3 cp $mysamplebase-GATK.bam s3://<yourS3bucket>/output_fg/$SAMPLELABEL-GATK.bam
aws s3 cp $mysamplebase-GATK.bai s3://<yourS3bucket>/output_fg/$SAMPLELABEL-GATK.bai