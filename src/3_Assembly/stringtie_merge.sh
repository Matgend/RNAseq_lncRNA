#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=8000M
#SBATCH --time=15:00:00
#SBATCH --job-name=stringTie
#SBATCH --mail-user=matthieu.gendre@student.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/home/mgendre/output_stingTie_merge_%j.o
#SBATCH --error=/data/courses/rnaseq/lncRNAs/Project1/matthieu/results/error_stringTie_merge_%j.e

module add UHTS/Aligner/stringtie/1.3.3b;

DIR=/data/courses/rnaseq/lncRNAs/Project1/matthieu/stringTie

path=/data/courses/rnaseq/lncRNAs/Project1

cd $DIR


stringtie --merge -p 4 -G $path/references/annotation_gtf/gencode.v35.annotation.gtf \
 -o stringtie_merged.gtf $path/matthieu/script/name_gtf.txt  


