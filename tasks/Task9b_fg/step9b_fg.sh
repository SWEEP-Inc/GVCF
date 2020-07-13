#!/bin/bash

#Setting up the dependecnies and loading the input files
mygatk="/dependencies/gatk-4.1.2.0"

myrefdir="/genome/references/"
outdir="/genome/output"
mysamplebase=$outdir"/"$SAMPLELABEL
aws s3 cp s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.fasta.gz /genome/references/Homo_sapiens_assembly38.fasta.gz
gunzip /genome/references/Homo_sapiens_assembly38.fasta.gz
aws s3 cp s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.fasta.fai /genome/references/Homo_sapiens_assembly38.fasta.fai
aws s3 cp s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.dict /genome/references/Homo_sapiens_assembly38.dict
aws s3 cp s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.dbsnp138.vcf.bgz $myrefdir"Homo_sapiens_assembly38.dbsnp138.vcf.bgz"
aws s3 cp s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.known_indels.vcf.gz $myrefdir"Homo_sapiens_assembly38.known_indels.vcf.gz"
aws s3 cp s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.dbsnp138.vcf.bgz.tbi $myrefdir"Homo_sapiens_assembly38.dbsnp138.vcf.bgz.tbi"
aws s3 cp s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.known_indels.vcf.gz.tbi $myrefdir"Homo_sapiens_assembly38.known_indels.vcf.gz.tbi"
myfasta="/genome/references/Homo_sapiens_assembly38.fasta"
mysnpgz=$myrefdir"Homo_sapiens_assembly38.dbsnp138.vcf.bgz" 
myindelgz=$myrefdir"Homo_sapiens_assembly38.known_indels.vcf.gz" # 59 MB
aws s3 cp s3://<yourS3bucket>/output_fg/$SAMPLELABEL-sort-rg-dedup.bam $mysamplebase-sort-rg-dedup.bam

# Running the module
cd $mygatk
./gatk BaseRecalibrator \
     -I $mysamplebase"-sort-rg-dedup.bam" \
     -R $myfasta \
     --known-sites $mysnpgz \
     --known-sites $myindelgz \
     -O $mysamplebase"-recal-table.txt"

# Writing the output to the s3 bucket
aws s3 cp $mysamplebase-recal-table.txt s3://<yourS3bucket>/output_fg/$SAMPLELABEL-recal-table.txt