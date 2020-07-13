# Simple linux-based OS to base our image on- very lightweight
FROM <yourDockerHubId>/genomics-workflow:optimised-base

# Update Pkg Mgr
RUN apt-get update

# Installing Java
RUN apt-get install openjdk-8-jdk -y

# install git
RUN apt-get install git -y

# Downloading and installing Picard
RUN cd /dependencies ; git clone https://github.com/broadinstitute/picard.git
RUN cd /dependencies/picard ; ./gradlew shadowJar

# Copying our script somewhere inside the image
COPY step2b_fg.sh /genome/scripts

# Compiling the script, making it into an executable
 RUN chmod +x /genome/scripts/step2b_fg.sh

# Command that runs the script when the image is run
 CMD /genome/scripts/step2b_fg.sh