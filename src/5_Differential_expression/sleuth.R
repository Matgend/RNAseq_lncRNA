#!/usr/bin/env Rscript

library(sleuth)
library(dplyr)

setwd("/data/courses/rnaseq/lncRNAs/Project1/matthieu/Rfolder")

sample_id <- dir(file.path("..","kallisto"))

print(sample_id)

kal_dirs <- file.path("..","kallisto",sample_id)

print(kal_dirs)

s2c <- read.table(file.path("..","script","exp_design.txt"), header = TRUE, stringsAsFactors = FALSE)
#s2c$cisplatin <- as.character(s2c$cisplatin)
s2c <- dplyr::select(s2c, sample, cisplatin)
print(s2c)

s2c <- dplyr::mutate(s2c, path = kal_dirs)

so <- sleuth_prep(s2c, read_bootstrap_tpm = TRUE,  num_cores = 1)

so <- sleuth_fit(so, ~cisplatin, "full")

so <- sleuth_fit(so, ~1, "reduced")

so <- sleuth_lrt(so, 'reduced', 'full')

sleuth_save(so, file = "so_object.rds") 

models(so) 

sleuth_table <- sleuth_results(so, 'reduced:full', 'lrt', show_all = FALSE)
sleuth_significant <- dplyr::filter(sleuth_table, qval <= 0.1)
#head(sleuth_significant, 20)

write.table(sleuth_table, file = "sleuth_table.txt", sep = "\t", row.names = FALSE)
write.table(sleuth_significant, file = "sleuth_significant.txt", sep = "\t", row.names = FALSE)

#sleuth_live(so)




