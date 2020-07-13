cd ./Task10b_fg
docker build -t task_10b_fg:optimised .

# Test run sample 1
docker run -e SAMPLELABEL="ERR000044" task_10b_fg:optimised

# Test run sample 2
#docker run -e SAMPLELABEL="ERR003341" task_10b_fg:optimised
