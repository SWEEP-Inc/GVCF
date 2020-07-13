cd ./Task9b_fg
docker build -t task_9b_fg:optimised .

# Test run sample 1
docker run -e SAMPLELABEL="ERR000044" task_9b_fg:optimised

# Test run sample 2
#docker run -e SAMPLELABEL="ERR003341" task_9b_fg:optimised
