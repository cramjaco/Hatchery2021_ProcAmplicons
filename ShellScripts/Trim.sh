#!/bin/bash

## Use cut-adapt to trim the primers off of everything
# First activate relevant condas environment, if cutadapt isn't live.

source activate cutadaptenv

rm -f RunData/cutadapt_primer_trimming_stats.txt
rm -f TrimmedSamples/*

for sample in $(cat Metadata/samples.txt)
do

    echo "On sample: $sample"
    
    cutadapt -a ^GTGYCAGCMGCCGCGGTAA...AAACTYAAAKRAATTGRCGG \
-A ^CCGYCAATTYMTTTRAGTTT...TTACCGCGGCKGCTGRCAC \
 -m 200 --discard-untrimmed \
    -o Trimmed/${sample}_R1_trim.fastq.gz -p Trimmed/${sample}_R2_trim.fastq.gz \
    Renamed/${sample}_R1.fastq.gz Renamed/${sample}_R2.fastq.gz \
    >> RunData/cutadapt_primer_trimming_stats.txt 2>&1
done

conda deactivate