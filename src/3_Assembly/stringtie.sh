#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=8000M
#SBATCH --time=15:00:00
#SBATCH --job-name=stringTie
#SBATCH --mail-user=matthieu.gendre@student.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/home/mgendre/output_stingTie_run_%j.o
#SBATCH --error=/data/courses/rnaseq/lncRNAs/Project1/matthieu/results/error_stringTie__%j.e

module add UHTS/Aligner/stringtie/1.3.3b;

DIR=/data/courses/rnaseq/lncRNAs/Project1/matthieu/hisat2

RESULTS=/data/courses/rnaseq/lncRNAs/Project1/matthieu/stringTie

path=/data/courses/rnaseq/lncRNAs/Project1/references


mkdir -p $RESULTS

cd $DIR

#for file in `ls`:
#do name=$(echo "$file" | cut -f 1 -d '.')
#stringtie -p 4 -G $path/annotation_gtf/gencode.v35.annotation.gtf -o $RESULTS/$name.gtf -l $name $file
#done

for file in `ls` 
do if [[ "$file" == *sample.bam ]]
then name=$(echo "$file" | cut -f 1 -d '.') 
stringtie -p 4 -G $path/annotation_gtf/gencode.v35.annotation.gtf -o $RESULTS/$name.gtf -l $name $file
fi
done


