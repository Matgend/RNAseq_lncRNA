#!/bin/bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1000M
#SBATCH --time=00:05:00
#SBATCH --job-name=kallisto_count_analysis
#SBATCH --output=/data/courses/rnaseq/lncRNAs/Project1/matthieu/results/analysis_gtf_output_%j.o
#SBATCH --error=/data/courses/rnaseq/lncRNAs/Project1/matthieu/results/analysis_gtf_error_%j.e

results=/data/courses/rnaseq/lncRNAs/Project1/matthieu/results

DIR=/data/courses/rnaseq/lncRNAs/Project1/matthieu/kallisto

cd $DIR

echo -e "sample\tnb_transcripts\tnb_novel_transcripts\tsum_tpm" > $results/analysis_kallisto.txt

for i in `ls`; do cd $i; echo -e "$i\t`tail -n +2 abundance.tsv | wc -l`\t`grep MSTRG -c abundance.tsv`\t" \
`awk '{s+=$5}END{print s}' abundance.tsv`; 
cd ..; done >> $results/analysis_kallisto.txt
#get a file with 4 columns : sample(name)	nb_transcripts	nb_novel transcripts	sum_tpm



