#!/bin/bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1000M
#SBATCH --time=01:00:00
#SBATCH --job-name=count
#SBATCH --mail-user=matthieu.gendre@students.unibe.ch
#SBATCH --mail-type=begin,end

cd /data/courses/rnaseq/lncRNAs/Project1/matthieu/fastq_merged/

for i in `ls`; 
do zcat $i | echo $i"\t"$((`wc -l`/4));
done >> /data/courses/rnaseq/lncRNAs/Project1/matthieu/results/reads_count.txt
