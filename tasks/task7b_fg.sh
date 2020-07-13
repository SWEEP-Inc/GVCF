cd ./Task7b_fg
docker build -t task_7b_fg:optimised .

# Test run sample 1
docker run -e SAMPLELABEL="ERR000044" task_7b_fg:optimised

# Test run sample 
#docker run -e SAMPLELABEL="ERR003341" task_7b_fg:optimised
