# Simple linux-based OS to base our image on- very lightweight
FROM <yourDockerHubId>/genomics-workflow:optimised-base

# install git
RUN apt-get install git -y

# Downloading and Installing BWA
RUN apt-get install zlib1g-dev
RUN cd /dependencies ; git clone https://github.com/lh3/bwa.git
RUN cd /dependencies/bwa ; make

# Dowloading and installing SAMTools
RUN apt-get install wget -y
RUN apt-get update && apt-get install -y apt-utils curl git tar gzip
RUN apt-get install zlib1g-dev 
RUN apt-get install libncurses-dev -y
RUN apt-get install libbz2-dev liblzma-dev -y
RUN wget -P /dependencies "https://github.com/samtools/samtools/releases/download/1.9/samtools-1.9.tar.bz2"
RUN cd /dependencies ; tar xvjf samtools-1.9.tar.bz2
RUN cd /dependencies/samtools-1.9 ; ./configure ; make ; make install

# Copying our script somewhere inside the image
COPY step6b_fg.sh /genome/scripts

# Compiling the script, making it into an executable
RUN chmod +x /genome/scripts/step6b_fg.sh

# Command that runs the script when the image is run
CMD /genome/scripts/step6b_fg.sh