cd ./Task1_fg
docker build -t task_1_fg:optimised .
# Add more memory to this task
docker run -it task_1_fg:optimised