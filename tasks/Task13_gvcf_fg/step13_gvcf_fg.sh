# !/bin/bash

# Setting up the dependencies and loading the input files
mypicard="/dependencies/picard/build/libs/picard.jar"

aws s3 cp "s3://<yourS3bucket>/"$VCF_OUTDIR"test_vcf_samples.list" /genome/references/test_vcf_samples.list

outdir="/genome/output/"

while read vcf_file; do
  echo $vcf_file
  aws s3 cp "s3://<yourS3bucket>/"$VCF_OUTDIR$vcf_file $outdir$vcf_file
  aws s3 cp "s3://<yourS3bucket>/"$VCF_OUTDIR$vcf_file".idx" $outdir$vcf_file".idx"
done < /genome/references/test_vcf_samples.list

# Combine per-chromosome vcf files into single joint vcf
java -Djava.io.tmpdir="$mytmpjava" -jar \
     $mypicard GatherVcfs \
     I="/genome/references/test_vcf_samples.list" \
     O=$outdir"GATK-Joint-Geno.vcf"

# Writing the output to s3
aws s3 cp $outdir"GATK-Joint-Geno.vcf" "s3://<yourS3bucket>/"$VCF_OUTDIR"GATK-Joint-Geno.vcf"
aws s3 cp $outdir"GATK-Joint-Geno.vcf.idx" "s3://<yourS3bucket>/"$VCF_OUTDIR"GATK-Joint-Geno.vcf.idx"
