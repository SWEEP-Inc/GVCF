# !/bin/bash

# Setting up the dependencies and loading the input files
aws s3 cp s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.fasta.gz /genome/references/Homo_sapiens_assembly38.fasta.gz
gunzip /genome/references/Homo_sapiens_assembly38.fasta.gz
aws s3 cp s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.fasta.fai /genome/references/Homo_sapiens_assembly38.fasta.fai
aws s3 cp s3://<yourS3bucket>/reference/Homo_sapiens_assembly38.dict /genome/references/Homo_sapiens_assembly38.dict
aws s3 cp s3://<yourS3bucket>/output_fg/gvcf/test_gvcf_samples.sample_map /genome/references/test_gvcf_samples.sample_map
aws s3 cp s3://<yourS3bucket>/output_fg/gvcf/test_gvcf_samples.list /genome/references/test_gvcf_samples.list

myfasta="/genome/references/Homo_sapiens_assembly38.fasta"
mygatk="/dependencies/gatk-4.1.2.0"

outdir="/genome/output/"

while read gvcf_file; do
  aws s3 cp "s3://<yourS3bucket>/output_fg/gvcf/"$gvcf_file $mygatk'/'$gvcf_file
  aws s3 cp "s3://<yourS3bucket>/output_fg/gvcf/"$gvcf_file".tbi" $mygatk'/'$gvcf_file".tbi"
done < /genome/references/test_gvcf_samples.list

# Create gvcf db
cd $mygatk
./gatk GenomicsDBImport \
    --sample-name-map /genome/references/test_gvcf_samples.sample_map \
    --genomicsdb-workspace-path my_database \
    -L $CHR

# Remove the wrk files
rm -r  ERR*

tar -cf my_database.tar my_database
workspace_tar='my_database.tar'
tar -xf ${workspace_tar}
workspace=$( basename ${workspace_tar} .tar)

# Perform oint variant calling
./gatk GenotypeGVCFs \
     -R $myfasta \
     -O $outdir"GATK-Joint-Geno-"$CHR".vcf" \
     -G StandardAnnotation \
     --only-output-calls-starting-in-intervals \
     --use-new-qual-calculator \
     -V gendb://$workspace \
     -L $CHR

# Writing the output to s3
aws s3 cp $outdir"GATK-Joint-Geno-"$CHR".vcf" "s3://<yourS3bucket>/"$VCF_OUTDIR"GATK-Joint-Geno-"$CHR".vcf"
aws s3 cp $outdir"GATK-Joint-Geno-"$CHR".vcf.idx" "s3://<yourS3bucket>/"$VCF_OUTDIR"GATK-Joint-Geno-"$CHR".vcf.idx"
