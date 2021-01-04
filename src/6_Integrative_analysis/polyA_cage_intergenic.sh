#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=1000M
#SBATCH --time=00:10:00
#SBATCH --job-name=intersect_job
#SBATCH --output=/data/courses/rnaseq/lncRNAs/Project1/matthieu/results/output_intersect_%j.o
#SBATCH --error=/data/courses/rnaseq/lncRNAs/Project1/matthieu/results/error_intersect_%j.e

module add UHTS/Analysis/BEDTools/2.29.2;
REF_DIR=/data/courses/rnaseq/lncRNAs/Project1/matthieu/references
DIR=/data/courses/rnaseq/lncRNAs/Project1/matthieu/
mkdir -p $DIR/intersect
cd $REF_DIR

WINDOWtss=25
WINDOWpoly=25

cp cage_peaks_hg38.bed cage_peaks_hg38_1.bed
sed -i -e 's/chr//' cage_peaks_hg38_1.bed
sed -i -e 's/M/MT/' cage_peaks_hg38_1.bed


#3' polyA sites

awk -v w=$WINDOWpoly -F "\t" '{$4=$5-w;$5=$5+w}{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8"\t"$9}' transcript_file.gtf > transcript_assembly_3end.gtf

sed -i -e 's/chr//' transcript_assembly_3end.gtf 
sed -i -e 's/M/MT/' transcript_assembly_3end.gtf 
sed -i -e 's/\"//g' transcript_assembly_3end.gtf 
sed -i -e 's/;//g' transcript_assembly_3end.gtf 

bedtools intersect -a transcript_assembly_3end.gtf -b atlas.clusters.2.0.GRCh38.96.bed -wa -f 6E-9 > $DIR/intersect/polyAsite_intersect.bed

#Generate a file with all the transcripts with polyA annotation
awk -F "\t" '{print$9}' $DIR/intersect/polyAsite_intersect.bed | tr -d ";\"" | awk -F " " '{print$4}'| uniq > $DIR/intersect/transcript_polyA.txt

#-f 6E-9 

#5' TSS sites

#bedtools sort -chrThenSizeA -i cage_peaks_hg38.bed

awk -v w=$WINDOWtss -F "\t" '{$4=$4-w;if($4<0){$4=1};$5=$4+w}{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8"\t"$9}' transcript_file.gtf > transcript_assembly_5end.gtf

sed -i -e 's/chr//' transcript_assembly_5end.gtf
sed -i -e 's/M/MT/' transcript_assembly_5end.gtf
sed -i -e 's/\"//g' transcript_assembly_5end.gtf
sed -i -e 's/;//g' transcript_assembly_5end.gtf

bedtools intersect -a transcript_assembly_5end.gtf -b cage_peaks_hg38_1.bed -wa -f 2E-8  > $DIR/intersect/TSS_intersect.bed

#Generate a file with all the transcripts with TSS annotation
awk -F "\t" '{print$9}' $DIR/intersect/TSS_intersect.bed | tr -d ";\"" | awk -F " " '{print$4}'| uniq > $DIR/intersect/tss_transcript.txt



#Intergenic

awk -F "\t" '{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8"\t"$9}' transcript_file.gtf > transcript_assembly_intergenic.gtf
sed -i -e 's/chr//' transcript_assembly_intergenic.gtf
sed -i -e 's/M/MT/' transcript_assembly_intergenic.gtf
sed -i -e 's/\"//g' transcript_assembly_intergenic.gtf
sed -i -e 's/;//g' transcript_assembly_intergenic.gtf

awk -F "\t" '{print $1"\t"$4"\t"$5"\t""NA""\t""NA""\t"$7"\t"$8"\t"$9}' gencode.v35.annotation.gtf > gencode.v35.annotation_1.gtf
#sed -i -e 's/\s/\t/g' gencode.v35.annotation_1.gtf
sed -i -e 's/chrM/MT/' gencode.v35.annotation_1.gtf
sed -i -e 's/chr//' gencode.v35.annotation_1.gtf

bedtools intersect -a $REF_DIR/transcript_assembly_intergenic.gtf -b $REF_DIR/gencode.v35.annotation_1.gtf -v > $DIR/intersect/novel_intergenic.bed

#Generate a file with all the intergenic transcripts
awk -F "\t" '{print$9}' $DIR/intersect/novel_intergenic.bed | tr -d ";\"" | awk -F " " '{print$4}'| uniq > $DIR/intersect/transcript_intergenic.txt
