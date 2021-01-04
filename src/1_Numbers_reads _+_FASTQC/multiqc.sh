#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1000M
#SBATCH --time=04:00:00
#SBATCH --job-name=multiqc
#SBATCH --mail-user=matthieu.gendre@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/courses/rnaseq/lncRNAs/Project1/matthieu/results/output_multicq_%j.o
#SBATCH --error=/data/courses/rnaseq/lncRNAs/Project1/matthieu/results/error_multiqc_%j.e


module add UHTS/Analysis/MultiQC/1.8;

cd /data/courses/rnaseq/lncRNAs/Project1/matthieu/fastqc

multiqc . --ignore *.html 


