# !/bin/bash

# Get all the relevant dependencies
mypicard="/dependencies/picard/build/libs/picard.jar"
mysamplebase="/genome/output/"$SAMPLELABEL
# Geting output of previous function from S3
aws s3 cp s3://<yourS3bucket>/output_fg/$SAMPLELABEL.bam $mysamplebase.bam

# Set read groups
myrgID=$SAMPLELABEL-LANE01 ### This needs to be a UNIQUE label!!
myrgSM=$SAMPLELABEL ## Sample. This will be used to name the output vcf
myrgLB=$SAMPLELABEL ## Library
myrgPL=illumina ## Platform/technology
myrgPU=$SAMPLELABEL

# Call and run the required modules
java -Djava.io.tmpdir="$mytmpjava" -jar \
     $mypicard AddOrReplaceReadGroups \
     I=$mysamplebase.bam \
     O=$mysamplebase-sort-rg.bam \
     SORT_ORDER=coordinate \
     CREATE_INDEX=true \
     USE_JDK_INFLATER=true \
     USE_JDK_DEFLATER=true \
     RGID=$myrgID RGSM=$myrgSM RGLB=$myrgLB RGPL=$myrgPL RGPU=$myrgPU

# Write the output to s3
aws s3 cp $mysamplebase-sort-rg.bam s3://<yourS3bucket>/output_fg/$SAMPLELABEL-sort-rg.bam
aws s3 cp $mysamplebase-sort-rg.bai s3://<yourS3bucket>/output_fg/$SAMPLELABEL-sort-rg.bai