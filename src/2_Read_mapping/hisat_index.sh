#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8500M
#SBATCH --time=02:40:00
#SBATCH --job-name=hisat2_index
#SBATCH --mail-user=matthieu.gendre@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/home/mgendre/output_hisat2_index_%j.o
#SBATCH --error=/home/mgendre/error_hisat2_index_%j.e


module add UHTS/Aligner/hisat/2.2.1

GENOME=/data/courses/rnaseq/lncRNAs/Project1/references/hg38/GRCh38.p13
INDEX_BASE=hg38
#list index ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_36/GRCh38.p13.genome.fa.gz
hisat2-build --ss ${INDEX_BASE}.ss --exon ${INDEX_BASE}.exon ${GENOME}.fa ${INDEX_BASE}

#--ss provide a list of splice site 
#--exon provide a list of exon

