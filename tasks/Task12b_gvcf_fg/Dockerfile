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

# Copying our script somewhere inside the image
COPY step12b_gvcf_fg.sh /genome/scripts

# Compiling the script, making it into an executable
RUN chmod +x /genome/scripts/step12b_gvcf_fg.sh

# Command that runs the script when the image is run
CMD /genome/scripts/step12b_gvcf_fg.sh
