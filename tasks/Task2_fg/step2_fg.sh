#!/bin/bash

# Set up the dependency variables
mypicard="/dependencies/picard/build/libs/picard.jar"

# The input file
aws s3 cp s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.fasta.gz /genome/references/Homo_sapiens_assembly38.fasta.gz
gunzip /genome/references/Homo_sapiens_assembly38.fasta.gz
myfasta="/genome/references/Homo_sapiens_assembly38.fasta"

# The outout file 
mydict="/genome/output/Homo_sapiens_assembly38.dict"
# Run the module
java -jar $mypicard CreateSequenceDictionary USE_JDK_INFLATER=true USE_JDK_DEFLATER=true R=$myfasta O=$mydict

# Write the output file to the s3 bucket
aws s3 cp /genome/output/Homo_sapiens_assembly38.dict  s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.dict