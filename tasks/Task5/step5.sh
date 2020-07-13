# !/bin/bash

# set up the dependencies
mygatk="/dependencies/gatk-4.1.2.0"
# temp directory for intermediate output
gatkroot="/genome/output/tmp"

# Input File
aws s3 cp s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.known_indels.vcf.gz /genome/references/Homo_sapiens_assembly38.known_indels.vcf.gz
myindelgz="/genome/references/Homo_sapiens_assembly38.known_indels.vcf.gz"

# Run the module
cd $mygatk
./gatk IndexFeatureFile -F $myindelgz

# Write the output
aws s3 cp /genome/references/Homo_sapiens_assembly38.known_indels.vcf.gz.tbi s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.known_indels.vcf.gz.tbi