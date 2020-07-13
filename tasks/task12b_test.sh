cd ./Task12b_gvcf_fg
docker build -t task_12b_gvcf_fg:optimised .

# Test run 1
docker run -e CHR="chr2" task_12b_gvcf_fg:optimised

# Test run 2
#docker run -e CHR="chr21" task_12b_gvcf_fg:optimised
