#!/usr/bin/env bash

#SBATCH --cpus-per-task=3
#SBATCH --mem-per-cpu=1000M
#SBATCH --time=10:00:00
#SBATCH --job-name=meged_fastq
#SBATCH --mail-user=matthieu.gendre@unifr.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/courses/rnaseq/lncRNAs/Project1/matthieu/results/output_fastqc_%j.o
#SBATCH --error=/data/courses/rnaseq/lncRNAs/Project1/matthieu/results/error_fastqc_%j.e


mkdir /data/courses/rnaseq/lncRNAs/Project1/matthieu/fastq_merged

DIR=/data/courses/rnaseq/lncRNAs/Project1/matthieu/fastq_merged
 
cd /data/courses/rnaseq/lncRNAs/Project1/fastq

#Merged the two lane files for each replicate, of each pair,  of each sample 
 
for i in 2 4 8; do 
for x in 1 2 3; do 
for j in 1 2; do
for file in D_Pt${i}_${x}_*_R${j}_001_*.fastq.gz; do 
cat "$file" >> $DIR/D_Pt${i}_${x}_R${j}_001.fastq.gz;
done; 
done; 
done; 
done


for i in 2 3; do 
for j in 1 2; do 
for file in A24wt_${i}_*_R${j}_001_*.fastq.gz; do 
cat "$file" >> $DIR/A24wt_${i}_R${j}_001.fastq.gz; 
done; 
done; 
done

 
for l in 1 2;
do for j in 1 2; 
do for file in A24wt_L${l}_R${j}_001_*.fastq.gz; 
do cat "$file" >> $DIR/A24wt_1_R${j}_001.fastq.gz; 
done; 
done; 
done

