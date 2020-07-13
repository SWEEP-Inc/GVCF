# Simple linux-based OS to base our image on- very lightweight
FROM <yourDockerHubId>/genomics-workflow:optimised-base

# install git
RUN apt-get install git -y

# Downloading and Installing BWA
RUN apt-get install zlib1g-dev
RUN cd /dependencies ; git clone https://github.com/lh3/bwa.git
RUN cd /dependencies/bwa ; make

# Copying our script somewhere inside the image
COPY step1_fg.sh /genome/scripts

# Compiling the script, making it into an executable
RUN chmod +x /genome/scripts/step1_fg.sh

# Command that runs the script when the image is run
CMD /genome/scripts/step1_fg.sh