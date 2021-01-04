#!/usr/bin/env bash


#SBATCH --cpus-per-task=3
#SBATCH --mem-per-cpu=1000M
#SBATCH --time=04:00:00
#SBATCH --job-name=fastqc
#SBATCH --mail-user=matthieu.gendre@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/courses/rnaseq/lncRNAs/Project1/matthieu/results/output_fastqc_%j.o
#SBATCH --error=/data/courses/rnaseq/lncRNAs/Project1/matthieu/results/error_fastqc_%j.e
#SBATCH --array=0-23


module add UHTS/Quality_control/fastqc/0.11.7
module add UHTS/Analysis/MultiQC/1.8;


READS_DIR=/data/courses/rnaseq/lncRNAs/Project1/matthieu/fastq_merged/

cd $READS_DIR

FILES=(*.fastq.gz)

fastqc -t 6 ${FILES[$SLURM_ARRAY_TASK_ID]}




 
