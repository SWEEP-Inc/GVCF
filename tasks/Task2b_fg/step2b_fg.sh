#!/bin/bash


# The outout file 
mydict="/genome/output/Homo_sapiens_assembly38.dict"

# The input file
aws s3 cp s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.dict.ref $mydict

# Write the output file to the s3 bucket
aws s3 cp /genome/output/Homo_sapiens_assembly38.dict  s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.dict