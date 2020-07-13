# !/bin/bash

# set up the dependencies
mygatk="/dependencies/gatk-4.1.2.0"
# temp directory for intermediate output
gatkroot="/genome/output/tmp"

# Input File
aws s3 cp s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.dbsnp138.vcf.bgz /genome/references/Homo_sapiens_assembly38.dbsnp138.vcf.bgz
mysnpgz="/genome/references/Homo_sapiens_assembly38.dbsnp138.vcf.bgz" 

# Run the module
cd $mygatk
./gatk IndexFeatureFile -F $mysnpgz

aws s3 cp /genome/references/Homo_sapiens_assembly38.dbsnp138.vcf.bgz.tbi s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.dbsnp138.vcf.bgz.tbi