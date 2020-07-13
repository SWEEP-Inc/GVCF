cd ./Task6b_fg
docker build -t task_6b_fg:optimised .

# Test run sample 2:
#docker run -e MYR1="http://1000genomes.s3.amazonaws.com/phase3/data/NA20524/sequence_read/ERR003341_1.filt.fastq.gz"" -e MYR2="http://1000genomes.s3.amazonaws.com/phase3/data/NA20524/sequence_read/ERR003341_2.filt.fastq.gz" -e SAMPLELABEL="ERR003341" task_6b_fg:optimised
