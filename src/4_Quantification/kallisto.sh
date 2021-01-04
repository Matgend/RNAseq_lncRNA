#!/usr/bin/env bash


#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=5000M
#SBATCH --time=35:00:00
#SBATCH --job-name=kallisto
#SBATCH --mail-user=matthieu.gendre@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/courses/rnaseq/lncRNAs/Project1/matthieu/results/output_kallisto_%j.o
#SBATCH --error=/data/courses/rnaseq/lncRNAs/Project1/matthieu/results/error_kallisto_%j.e

module add UHTS/Analysis/kallisto/0.46.0;

results=/data/courses/rnaseq/lncRNAs/Project1/matthieu/kallisto

mkdir -p $results

index=/data/courses/rnaseq/lncRNAs/Project1/matthieu/references

genome=/data/courses/rnaseq/lncRNAs/Project1/references/hg38

DIR=/data/courses/rnaseq/lncRNAs/Project1/matthieu

cd $DIR/fastq_merged


for i in 1 2 3; do 
file=`echo A24wt_${i}_*`;
kallisto quant -i $index/hg38.transcript.idx -b 100 -o $results/A24wt_${i} $file 
done

for i in 2 4 8; do 
for x in 1 2 3; do 
file=`echo D_Pt${i}_${x}_*`;
kallisto quant -i $index/hg38.transcript.idx -b 100  -o $results/D_Pt${i}_${x} $file 
done
done

