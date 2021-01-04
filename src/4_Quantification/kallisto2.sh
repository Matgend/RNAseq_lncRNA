#!/usr/bin/env bash


#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=5500M
#SBATCH --time=10:00:00
#SBATCH --job-name=kallisto2
#SBATCH --mail-user=matthieu.gendre@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/courses/rnaseq/lncRNAs/Project1/matthieu/results/output_kallisto2_%j.o
#SBATCH --error=/data/courses/rnaseq/lncRNAs/Project1/matthieu/results/error_kallisto2_%j.e


module add UHTS/Analysis/kallisto/0.46.0;

results=/data/courses/rnaseq/lncRNAs/Project1/matthieu/kallisto

mkdir -p $results

index=/data/courses/rnaseq/lncRNAs/Project1/matthieu/references

genome=/data/courses/rnaseq/lncRNAs/Project1/references/hg38

DIR=/data/courses/rnaseq/lncRNAs/Project1/matthieu

cd $DIR/fastq_merged

kallisto quant -i $index/hg38.transcript.idx -b 100  -o $results/D_Pt8_3  D_Pt8_3_R1_001.fastq.gz D_Pt8_3_R2_001.fastq.gz 

 
