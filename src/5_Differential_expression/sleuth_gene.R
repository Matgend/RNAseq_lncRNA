#!/usr/bin/env Rscript

require(tidyverse)
library("sleuth")
library("dplyr")

setwd("/data/courses/rnaseq/lncRNAs/Project1/matthieu/Rfolder")

library("biomaRt")

sample_id <- dir(file.path("..","kallisto"))

kal_dirs <- file.path("..","kallisto",sample_id)

s2c <- read.table(file.path("..","script","exp_design.txt"), header = TRUE, stringsAsFactors = FALSE)

s2c <- dplyr::mutate(s2c, path = kal_dirs)

mart <- biomaRt::useMart(biomart = "ENSEMBL_MART_ENSEMBL", dataset = "hsapiens_gene_ensembl", host = 'ensembl.org')
t2g <- biomaRt::getBM(attributes = c("ensembl_transcript_id","transcript_version", "ensembl_gene_id", "external_gene_name"), mart = mart)
anno <- dplyr::rename(t2g, target_id = ensembl_transcript_id, ens_gene = ensembl_gene_id, ext_gene = external_gene_name)
anno <- anno %>% unite(target_id, target_id:transcript_version, sep = ".")

#s2c <- dplyr::select(s2c, sample, cisplatin)

so <- sleuth_prep(s2c, extra_bootstrap_summary = TRUE,target_mapping = anno)

so <- sleuth_fit(so, ~cisplatin, 'full')

so <- sleuth_fit(so, ~1, 'reduced')

so <- sleuth_lrt(so, 'reduced', 'full')

sleuth_save(so, file = "so_object_genes.rds")

sleuth_table <- sleuth_results(so, 'reduced:full', 'lrt', show_all = FALSE)
sleuth_significant <- dplyr::filter(sleuth_table, qval <= 0.1)
write.table(sleuth_table,file = "sleuth_table_genes.txt", sep = "\t")
write.table(sleuth_significant,file = "sleuth_significant_genes.txt", sep = "\t")

jpeg('group_density_plot.jpg')
plot_group_density(so, use_filtered = TRUE, units = "est_counts",
  trans = "log", grouping = setdiff(colnames(so$sample_to_covariates),
  "sample"), offset = 1)
dev.off()
