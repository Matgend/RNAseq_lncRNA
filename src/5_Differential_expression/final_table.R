#!/usr/bin/env Rscript

setwd("/data/courses/rnaseq/lncRNAs/Project1/matthieu/Rfolder")

#load files
table_genes <- read.table("sleuth_table_genes.txt", header = T)
tr_noprotein <- read.table("../cpat/transcript_non_protein.txt")
tr_intergenic <- read.table("../intersect/transcript_intergenic.txt")
tr_TSS <- read.table("../intersect/tss_transcript.txt")
tr_polyA <- read.table("../intersect/transcript_polyA.txt")
tr_b200 <- read.table("../references/transcript_b200.txt")
data <- readRDS("final_dataframe.rds")
head(data)

data <- cbind(data, target_id = rownames(data))
head(data)
order(data$target_id)
d <- data[order(data$target_id),]
head(d)
final_table <- table_genes[order(table_genes$target_id),]
head(final_table)

all(final_table$target_id==d$target_id)

final_table <- cbind(final_table, log2_FC_2 = log2(d$ratePt2), log2_FC_4 = log2(d$ratePt3), log2_FC_8 = log2(d$ratePt4))
head(final_table)




dim(table_genes)
#Create the final table used for the statistics analysis
final_table <- cbind(final_table, no_protein = rep(0, length.out = dim(final_table)[1]), intergenic = rep(0, length.out = dim(final_table)[1]),
TSS = rep(0, length.out = dim(final_table)[1]), polyA = rep(0, length.out = dim(final_table)[1]), b200 = rep(0, length.out = dim(final_table)[1]))

for (i in 1:dim(final_table)[1]){
  if (final_table$target_id[i] %in% tr_noprotein$V1){
    final_table$no_protein[i] <- tr_noprotein$V2 
  }
}

for (i in 1:dim(final_table)[1]){
  if (final_table$target_id[i] %in% tr_intergenic$V1){
    final_table$intergenic[i] <- 1
  }
}

for (i in 1:dim(final_table)[1]){
  if (final_table$target_id[i] %in% tr_TSS$V1){
    final_table$TSS[i] <- 1
  }
}

for (i in 1:dim(final_table)[1]){
  if (final_table$target_id[i] %in% tr_polyA$V1){
    final_table$polyA[i] <- 1
  }
}

for (i in 1:dim(final_table)[1]){
  if (final_table$target_id[i] %in% tr_b200$V1){
    final_table$b200[i] <- 1
  }
}


write.csv(final_table, file = "final_table_genes.csv")


 
