RNAseq_lncRNA

#Data
The data is composed of 48 fastq.gz files separeted in 4 subline. Each subline is composed of 12 files. The files are in the repository  ../Project1/fastq

#Merge the fastq.gz
Run fastq_merged2.sh  which merge the two lanes of each fastqt.gz. The repository is /fastq_merged

#Number of reads
Run the counting_reads.sh will gives the output reads_count.txt which display the number of reads in each fastq.gz files

#FastQC and MultiQC
Run fastqc.sh. Input are the fastq_merged files. Output fastqc.zip and fastqc.html files.
Run multiqc.sh. Input are fastqc.html files and the ouput is a multiqc.html

#Read mapping

##HISAT2
Create a index for hisat2, run hisat_index.sh which use as reference annotation, GRCh38.p13.genome.fa.gz. Return 10 files
Run hisat2_run.sh. Input fastq_merged files. Output  bam files for each sbuline replicates. 

##Samtools
Merge the bam file of each replicates in one global bam file for eacn subline:
Run samtools_merge.sh. Input bam file. Ouput three bam files 

#Assembly

##Stringtie
Run sringtie.sh. Input bam files, output gtf file for each subline. Use as annotation reference, gencode.v35.annotation.gtf
Run stringtie_merge.sh to merged the gtf files in one gtf file called stringtie_merged.gtf (meta assembly)

#Quantification
Run kallisto_index.sh which will create hg38.transcript.idx file through GRCh38.p13.genome.fa  and stringtie_merged.gtf which will be use for kallisto
Run kallisto.sh. Input, fastq merged, Output abudance.h5, abundance.tsv and run_info.json for each subline replicates
Analyse the numbers of transcripts, novel transcript and tpm running the file analysis_kallisto.sh

#Differential_expression
Run sleuth.sh which will run sleuth.R.
sleuth.R input kallisto outputs and return a sleuth_table.txt and a sleuth significante_txt locallised in 
results/Rfolder. 
Run sleuth_gene.R through sleuth.sh to add the gene names of the tables.

#Inegrative analysis

##PolyA, Cage and Intergenic.
Run polyA_cage_intergenic.sh. 
For cage: Input, cage_peaks_hg38 and transcript_file.gtf. Output, tss_transcript.txt
For polyA: Input, transcript_file.gtf, atlas.clusters.2.0.GRCh38.96.bed. Output, transcript_polyA.txt
For intergenic: Input, transcript_file.gtf , gencode.v35.annotation.gtf. Output, transcript_intergenic.txt

##CPAT
Run cpat.sh

#Final table generation
Run final_table.R and FFinal_script.R
Outputs: table_under_2c.csv, table_under_4c.csv, table_under_8c.csv, table_over_2c.csv
table_over_4c.csv, table_over_8c.csv and lncRNAs_literature.csv

