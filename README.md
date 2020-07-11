### Workflow Description

This SWEEP workflow (termed as JVCF from here onwards) represents the Joint Variant Calling Workflow based on GATK Best Practices [^1].

The GATK best-practice joint variant calling pipeline was implemented as a SWEEP workflow comprising 18 **tasks**. The workflow starts by setting per-sample metadata for the entire population required to orchestrate subsequent tasks is prepared and propagated onwards. Tasks 2-6 are then run in parallel, preparing onetime index files from the reference sequence and known SNP/indel files. 
The remainder of the workflow tasks rely on the successful completion of each predecessor and are run sequentially. Tasks 7-13 are scattered by sample, and produce QC'd GVCF files from the paired-end read files for each sample. Task 14 takes inventory of all GVCF files that have been successfully produced by task 12 and defines the separate task variables for task 15, which is scattered by chromosome. 
Joint variant calling is performed for chromosomes 1-22 in separate container tasks, and the VCF outputs of each task are stitched together by the **Picard** GatherVCFs function in task 17. The final output of the workflow is a single joint VCF file that contains SNP and indel information for each sample included in the workflow. 
The final output of the workflow is a single joint VCF file that contains SNP and indel information for each sample included in the workflow. 

### Our Use Case 

* Joint variant calling of [1000 Genomes] [2] data

### Implementation 

* SWEEP **tasks** are pre deployed to the cloud provider, and SWEEP provides the Workflow manangement backbone


### Open Issues 

* SWEEP on AWS/Azure limits to 64 individuals.
* Sex chromosomes are excluded in the original runs.

### Benchmarking
                   
We have run it via AWS amd Azure

### Running without SWEEP Platform 

Each of the tasks mentioned in the workflow can be run independently using **Docker**.

### API (Python )
SWEEP workflows can be invoked via **API**. For more information, please visit our [documentation](https://docs.sweep.run).

```python

```

### References.

[1]: [Germline short variant discovery (SNPs + Indels)](https://gatk.broadinstitute.org/hc/en-us/articles/360035535932-Germline-short-variant-discovery-SNPs-Indels-)  
[2]: [A global reference for human genetic variation](https://www.nature.com/articles/nature15393)  

### References.

[^1]: [Germline short variant discovery (SNPs + Indels)](https://gatk.broadinstitute.org/hc/en-us/articles/360035535932-Germline-short-variant-discovery-SNPs-Indels-)  
