#!/bin/bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1000M
#SBATCH --time=01:00:00
#SBATCH --job-name=count_gtf_analysis
#SBATCH --mail-user=matthieu.gendre@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/courses/rnaseq/lncRNAs/Project1/matthieu/results/analysis_gtf_output_%j.o
#SBATCH --error=/data/courses/rnaseq/lncRNAs/Project1/matthieu/results/analysis_gtf_error_%j.e

results=/data/courses/rnaseq/lncRNAs/Project1/matthieu/results

DIR=/data/courses/rnaseq/lncRNAs/Project1/matthieu/stringTie

cd $DIR

#get nbr of exons
awk -F "\t" '$3 == "exon"{counter+=1}END{print "exon: ", counter}' stringtie_merged.gtf  > $results/analysis_gtffile.txt 

#get nbr of transcripts
awk -F "\t" '$3 == "transcript"{counter+=1}END{print "transcript (=gene): ", counter}' stringtie_merged.gtf >> $results/analysis_gtffile.txt

#nbr of transcript having one gene
awk -F "\t" '$3 == "exon" {print$9}' stringtie_merged.gtf | tr -d ";\"" | awk -F " " '{exon_counter[$4] += 1}\
END {
    for (transcript_id in exon_counter) {
        print transcript_id, exon_counter[transcript_id]
    }
}' > $results/nbr_exons_transcript.txt
echo "transcripts one exon" >> $results/analysis_gtffile.txt
awk '$2 == 1' $results/nbr_exons_transcript.txt | wc -l >> $results/analysis_gtffile.txt


#novel  transcripts
echo "novel transcript" >> $results/analysis_gtffile.txt
awk -F "\t" '$3 == "transcript"' stringtie_merged.gtf | awk -F " " '{if ($15!="ref_gene_id") print$15}' | wc -l  >> $results/analysis_gtffile.txt



 



