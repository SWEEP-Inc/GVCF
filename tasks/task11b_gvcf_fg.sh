cd ./Task11b_gvcf_fg
docker build -t task_11b_gvcf_fg:optimised .

# Test run sample 1
docker run -e SAMPLELABEL="ERR000044" task_11b_gvcf_fg:optimised

# Test run sample 2
#docker run -e SAMPLELABEL="ERR003341" task_11b_gvcf_fg:optimised
