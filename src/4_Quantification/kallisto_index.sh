#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH	--mem-per-cpu=5000M
#SBATCH --time=20:00:00
#SBATCH --job-name=kallisto_index
#SBATCH --mail-user=matthieu.gendre@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/courses/rnaseq/lncRNAs/Project1/matthieu/results/output_kallistoin_%j.o
#SBATCH --error=/data/courses/rnaseq/lncRNAs/Project1/matthieu/results/output_kallistoin_%j.e

module add UHTS/Analysis/kallisto/0.46.0

module add UHTS/Assembler/cufflinks/2.2.1

DIR=/data/courses/rnaseq/lncRNAs/Project1/matthieu/stringTie

cd /data/courses/rnaseq/lncRNAs/Project1/matthieu/references

#GRCh38.p13.genome.fa : ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_35/GRCh38.p13.genome.fa.gz
#stringtie_merged.gtf (meta-assembly) use comprehensive gene annotation file : ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_35/gencode.v35.annotation.gtf.gz 

gffread -w transcripts.fa -g GRCh38.p13.genome.fa $DIR/stringtie_merged.gtf

kallisto index -i hg38.transcript.idx transcripts.fa



