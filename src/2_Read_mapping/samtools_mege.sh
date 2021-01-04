#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=8000M
#SBATCH --time=35:00:00
#SBATCH --job-name=hisat2_run
#SBATCH --mail-user=matthieu.gendre@student.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/home/mgendre/output_samtools_merge_%j.o
#SBATCH --error=/data/courses/rnaseq/lncRNAs/Project1/matthieu/results/samtools_merge_%j.e

module add UHTS/Analysis/samtools/1.10;

DIR=/data/courses/rnaseq/lncRNAs/Project1/matthieu/hisat2

cd $DIR

samtools merge A2wt_sample.bam A24wt_1.bam A24wt_2.bam A24wt_3.bam

samtools merge D_Pt2_sample.bam D_Pt2_1.bam D_Pt2_2.bam D_Pt2_3.bam

samtools merge D_Pt4_sample.bam D_Pt4_1.bam D_Pt4_2.bam D_Pt4_3.bam

samtools merge D_Pt8_sample.bam D_Pt8_1.bam D_Pt8_2.bam D_Pt8_3.bam

   

