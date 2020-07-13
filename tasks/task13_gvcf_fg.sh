cd ./Task13_gvcf_fg
docker build -t task_13_gvcf_fg:optimised .

# Test run
docker run -e VCF_OUTDIR="output_fg/gvcf/joint_vcf_2_samples/" task_13_gvcf_fg:optimised

