# !/bin/bash

# settung up the dependencies required for this step
mypicard="/dependencies/picard/build/libs/picard.jar"
mysamplebase="/genome/output/"$SAMPLELABEL
aws s3 cp s3://<yourS3bucket>/output_fg/$SAMPLELABEL-sort-rg.bam $mysamplebase-sort-rg.bam

# Running the module
java -jar $mypicard MarkDuplicates \
     I=$mysamplebase-sort-rg.bam \
     O=$mysamplebase-sort-rg-dedup.bam \
     M=$mysamplebase-dedup-metric.txt \
     ASSUME_SORT_ORDER=coordinate \
     CREATE_INDEX=true \
     USE_JDK_INFLATER=true \
     USE_JDK_DEFLATER=true \

# Writing the output to the s3 bucket
aws s3 cp $mysamplebase-sort-rg-dedup.bam s3://<yourS3bucket>/output_fg/$SAMPLELABEL-sort-rg-dedup.bam
aws s3 cp $mysamplebase-sort-rg-dedup.bai s3://<yourS3bucket>/output_fg/$SAMPLELABEL-sort-rg-dedup.bai