# Simple linux-based OS to base our image on- very lightweight
FROM <yourDockerHubId>/genomics-workflow:optimised-base

# Update Pkg Mgr
RUN apt-get update

# Installing Java
RUN apt-get install openjdk-8-jdk -y

# Dowloading and installing GATK
RUN apt-get install wget -y
RUN apt-get update && apt-get install -y unzip zip
RUN wget -P /dependencies "https://github.com/broadinstitute/gatk/releases/download/4.1.2.0/gatk-4.1.2.0.zip"
RUN cd /dependencies ; unzip gatk-4.1.2.0.zip

# Dowloading and installing HTSlib
RUN apt-get install wget -y
RUN apt-get update && apt-get install -y apt-utils curl git tar gzip
RUN apt-get install zlib1g-dev 
RUN apt-get install libncurses-dev -y
RUN apt-get install libbz2-dev liblzma-dev -y
RUN wget -P /dependencies "https://github.com/samtools/htslib/releases/download/1.10.2/htslib-1.10.2.tar.bz2"
RUN cd /dependencies ; tar xvjf htslib-1.10.2.tar.bz2
RUN cd /dependencies/htslib-1.10.2 ; ./configure ; make ; make install

# Copying our script somewhere inside the image
COPY step11b_gvcf_fg.sh /genome/scripts

# Compiling the script, making it into an executable
RUN chmod +x /genome/scripts/step11b_gvcf_fg.sh

# Command that runs the script when the image is run
CMD /genome/scripts/step11b_gvcf_fg.sh