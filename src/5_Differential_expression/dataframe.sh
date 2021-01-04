#!/usr/bin/env bash

#SBATCH --cpus-per-task=3
#SBATCH --mem-per-cpu=5000M
#SBATCH --time=2:00:00
#SBATCH --job-name=dataframe
#SBATCH --output=/data/courses/rnaseq/lncRNAs/Project1/matthieu/results/output_dataframe_%j.o
#SBATCH --error=/data/courses/rnaseq/lncRNAs/Project1/matthieu/results/error_dataframe_%j.e

module add R/3.6.1

DIR=/data/courses/rnaseq/lncRNAs/Project1/matthieu/script

#Rscript $DIR/dataframe_volcano.R
#Rscript $DIR/dataframe_volcano_test.R
#Rscript $DIR/dataframe_volcano.R
Rscript $DIR/final_table.R
