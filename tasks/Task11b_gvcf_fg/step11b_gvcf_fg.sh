# !/bin/bash

# Setting up the dependencies and loading the input files
aws s3 cp s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.fasta.gz /genome/references/Homo_sapiens_assembly38.fasta.gz
gunzip /genome/references/Homo_sapiens_assembly38.fasta.gz
aws s3 cp s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.dbsnp138.vcf.bgz /genome/references/Homo_sapiens_assembly38.dbsnp138.vcf.bgz
aws s3 cp s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.fasta.fai /genome/references/Homo_sapiens_assembly38.fasta.fai
aws s3 cp s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.dict /genome/references/Homo_sapiens_assembly38.dict
aws s3 cp s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.dbsnp138.vcf.bgz.tbi /genome/references/Homo_sapiens_assembly38.dbsnp138.vcf.bgz.tbi
myfasta="/genome/references/Homo_sapiens_assembly38.fasta"
mygatk="/dependencies/gatk-4.1.2.0"
myhtslib="/dependencies/htslib-1.10.2"
mysnp="/genome/references/Homo_sapiens_assembly38.dbsnp138.vcf.bgz"

outdir="/genome/output"
mysamplebase=$outdir"/"$SAMPLELABEL


aws s3 cp s3://<yourS3bucket>/output_fg/$SAMPLELABEL-GATK.bam $mysamplebase-GATK.bam
aws s3 cp s3://<yourS3bucket>/output_fg/$SAMPLELABEL-GATK.bai $mysamplebase-GATK.bai

# Running the module
cd $mygatk
./gatk HaplotypeCaller \
     -R $myfasta \
     -I $mysamplebase"-GATK.bam" \
     -ERC GVCF \
     --dbsnp  $mysnp \
     -O $mysamplebase"-GATK-HC.g.vcf"

# Zip the gvcf file
cd $myhtslib
./bgzip -c $mysamplebase"-GATK-HC.g.vcf" > $mysamplebase"-GATK-HC.g.vcf.gz"

# Create index file for gvcf.gz
./tabix -p vcf $mysamplebase"-GATK-HC.g.vcf.gz"


# Writing the output to s3
aws s3 cp $mysamplebase'-GATK-HC.g.vcf.gz' s3://<yourS3bucket>/output_fg/gvcf/$SAMPLELABEL'-GATK-HC.g.vcf.gz'
aws s3 cp $mysamplebase'-GATK-HC.g.vcf.gz.tbi' s3://<yourS3bucket>/output_fg/gvcf/$SAMPLELABEL'-GATK-HC.g.vcf.gz.tbi'
