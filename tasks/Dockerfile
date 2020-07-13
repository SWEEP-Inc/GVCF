# Simple linux-based OS to base our image on- very lightweight
FROM ubuntu:18.04

# Installing Python
RUN apt-get update \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip

# Installing awscli
RUN pip3 install awscli

# Configuring the awscli
RUN aws configure set aws_access_key_id <yourAWSAccessKey>
RUN aws configure set aws_secret_access_key <yourAWSSecretAccessKey>
RUN aws configure set region us-west-1

# Creating all the directories we need and the structure of our image
WORKDIR /dependencies
WORKDIR /genome
WORKDIR /genome/scripts
WORKDIR /genome/references
WORKDIR /genome/output