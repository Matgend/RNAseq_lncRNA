#!/usr/bin/env bash

#SBATCH --cpus-per-task=3
#SBATCH --mem-per-cpu=7000M
#SBATCH --time=3:00:00
#SBATCH --job-name=sleuth
#SBATCH --mail-user=matthieu.gendre@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/courses/rnaseq/lncRNAs/Project1/matthieu/results/output_sleuth_%j.o
#SBATCH --error=/data/courses/rnaseq/lncRNAs/Project1/matthieu/results/error_sleuth_%j.e

module add R/3.6.1

DIR=/data/courses/rnaseq/lncRNAs/Project1/matthieu/script

#Rscript $DIR/sleuth.R 

Rscript $DIR/sleuth_gene.R

