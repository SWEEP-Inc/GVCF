### Workflow Description

This SWEEP workflow (termed as GVCF from here onwards) represents the Joint Variant Calling Workflow based on GATK Best Practices [#1].

The GATK best-practice joint variant calling pipeline was implemented as a SWEEP workflow comprising 18 [**tasks**](/tasks). The workflow starts by setting per-sample metadata for the entire population required to orchestrate subsequent tasks is prepared and propagated onwards. Tasks 2-6 are then run in parallel, preparing onetime index files from the reference sequence and known SNP/indel files. 
The remainder of the workflow tasks rely on the successful completion of each predecessor and are run sequentially. Tasks 7-13 are scattered by sample, and produce QC'd GVCF files from the paired-end read files for each sample. Task 14 takes inventory of all GVCF files that have been successfully produced by task 12 and defines the separate task variables for task 15, which is scattered by chromosome. 
Joint variant calling is performed for chromosomes 1-22 in separate container tasks, and the VCF outputs of each task are stitched together by the **Picard** GatherVCFs function in task 17. The final output of the workflow is a single joint VCF file that contains SNP and indel information for each sample included in the workflow. 
The final output of the workflow is a single joint VCF file that contains SNP and indel information for each sample included in the workflow. 

Each *Task* in GVCF has a corresponding folder; under each of the Task folder you will find Docker compose file, and a batch script to create the docker image. In all cases
the shell scripts with  a sample invocation that you can use can be found in the 'tasks' folder (root folder to to all the **Tasks**).
 
### Our Use Case 

* Joint variant calling of 1000 Genomes [2] data with [62 individuals](/tasks/Task0/all_eur_afr_pruned.csv). The files are part of AWS Open data initiative, and are located at
[http://1000genomes.s3.amazonaws.com/phase3/data/](http://1000genomes.s3.amazonaws.com/phase3/data/).  

### Implementation 

* SWEEP **tasks** are pre deployed to the cloud provider, and SWEEP provides the Workflow manangement backbone, but you can run it without SWEEP

### Setup

* Push the base image to your **yourDockerHubId**, once pushed, update the repository location in all your task Docker compose files
* In the shell scripts, a S3 bucket is used as a handoff between the tasks. So, whereever s3://**yourS3bucket** appears in te shell script, it needs to be changed to a S3 bucket you have read-write access to.
* Base docker compose file has placeholders for AWS credentials that needs to be replaced, namely <yourAWSAccessKey> & <yourAWSSecretAccessKey>

### Open Issues 

* SWEEP on AWS/Azure limits to 62 individuals.
* Sex chromosomes are excluded in the original runs.

### Benchmarking
                   
We have run it via AWS amd Azure. Instructions in this repository is for AWS, but can be run against Azure as well.

### Running without SWEEP Platform 

Each of the tasks mentioned in the workflow can be run independently using **Docker**.

### Running on SWEEP Platform 

Please sign-up at https://sweep.run

### API (Python )

SWEEP workflows can be invoked via **API**. For more information, please visit our [documentation](https://docs.sweep.run).

```python

```
### Issues

If you have input or feedback or you find issues, please suggest it throught issues feature on this GitHub repository.

### References.

[1]: [Germline short variant discovery (SNPs + Indels)](https://gatk.broadinstitute.org/hc/en-us/articles/360035535932-Germline-short-variant-discovery-SNPs-Indels-)  
[2]: [A global reference for human genetic variation](https://www.nature.com/articles/nature15393)  

