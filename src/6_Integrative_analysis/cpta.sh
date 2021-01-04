#!/usr/bin/env bash 
#SBATCH --cpus-per-task=4 
#SBATCH --mem-per-cpu=2000M 
#SBATCH --time=02:00:00 
#SBATCH --job-name=cpat
#SBATCH --mail-user=matthieu.gendre@students.unibe.ch 
#SBATCH --mail-type=begin,end 
#SBATCH --output=/data/users/mgendre/output_cpat_%j.o 
#SBATCH --error=/data/users/mgendre/error_cpat_%j.e

module add SequenceAnalysis/GenePrediction/cpat/1.2.4;

module add R/3.6.1 

READS_DIR=/data/courses/rnaseq/lncRNAs/Project1/matthieu/fastq_merged 

HOME_DIR=/data/courses/rnaseq/lncRNAs/Project1/matthieu/references

mkdir -p /data/courses/rnaseq/lncRNAs/Project1/matthieu/cpat

OUT_DIR=/data/courses/rnaseq/lncRNAs/Project1/matthieu/cpat

cd $HOME_DIR
 
wget https://sourceforge.net/projects/rna-cpat/files/v1.2.2/prebuilt_model/Human_Hexamer.tsv 

wget https://sourceforge.net/projects/rna-cpat/files/v1.2.2/prebuilt_model/Human_logitModel.RData

cpat.py -g transcripts.fa -x Human_Hexamer.tsv -d Human_logitModel.RData -o $OUT_DIR/cpat_output

awk -F "\t" '{if($6 < 0.364){print $1"\t"$6}}' ../cpat/cpat_output > transcript_non_protein.txt 
