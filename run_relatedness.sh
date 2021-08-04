#!/bin/bash
set -euo pipefail

#input file of sampleID, gvcf location, seq type
gvcf_list=$1
output_dir=$2
purcell_sites=""

# read in list of gVCFs and
while read sample, gvcf, seq
    do  
        echo -e  "$sample\t$sample_$seq" > ${output_dir}/${sample}.header 
        bcftools reheader -s ${output_dir}/${sample}.header ${gvcf} -o "reheader_"${gvcf} 
        bcftools view -R ${purcell_sites} -Oz -o ${output_dir}/${sample}_purcell_${seq}.g.vcf.gz
    done < ${gvcf_list} 
#for each gvcf
# get sample ID

# reheader to include seq type in sample ID

# subset to purcell 5k sites

# combine all gVCFs in file (regardless of sequencing) 
ls *purcell*.g.vcf.gz > ${output_dir}/purcell_gvcf_files.list
bcftools merge -l ${output_dir}/purcell_gvcf_files.list -Oz -o ${output_dir}/merged_purcell_g.vcf.gz

#TODO: do I need to do an intersect first?

# Run relatedness using vcftools

# identify duplicate samples 

