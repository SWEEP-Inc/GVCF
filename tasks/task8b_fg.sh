cd ./Task8b_fg
docker build -t task_8b_fg:optimised .

# Test run sample 1
docker run -e SAMPLELABEL="ERR000044" task_8b_fg:optimised

# Test run sample 2
#docker run -e SAMPLELABEL="ERR003341" task_8b_fg:optimised
