#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=8000M
#SBATCH --time=24:00:00
#SBATCH --job-name=hisat2_run
#SBATCH --mail-user=matthieu.gendre@student.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/home/mgendre/output_merge_stringtie_%j.o
#SBATCH --error=/data/courses/rnaseq/lncRNAs/Project1/matthieu/results/error_merge_stringtie_%j.e






