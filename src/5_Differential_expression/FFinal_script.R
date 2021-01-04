setwd("C:/Users/Matthieu/Desktop/RNAseq")
library(tidyverse)
#library(EnhancedVolcano)
library(dbplyr)
data <- read.csv("final_table_genes.csv", header = T)
tr_noprotein <- read.csv("transcript_non_protein.csv")
#data$X <- NULL


#filter data to keep only the transcripts coding not for a protein, having a good 5' and 3' annotation and with a size of 200 or more nt and more than one exon 
df <- data %>% filter(data$no_protein == 1, data$TSS == 1, data$polyA == 1, data$b200 == 1, data$one_exon == 0)

#keep only the intergenic from df
df_intergenic <- df %>% filter(df$intergenic == 1, df$one_exon == 0)

#plot volcano plot with transcript id in labels
EnhancedVolcano(df, lab = df$target_id, x = 'log2_FC_2', y = 'qval', FCcutoff = log2(1.5), pCutoff = 0.1, title = 'WT versus 2C',
                legendLabels=c('Not sig.','Log (base 2) FC','q-value',
                               'q-value & Log (base 2) FC'))




#filter transcripts having log2FC [-1.5;1.5] (FC = [-1.5;1.5])
data_under_condition2 <- dplyr::filter(df, log2_FC_2 <= -log2(2), qval <= 0.0001)
data_under_condition3 <- dplyr::filter(df, log2_FC_4 <= -log2(2), qval <= 0.0001)
data_under_condition8 <- dplyr::filter(df, log2_FC_8 <= -log2(2), qval <= 0.0001)

data_over_condition2 <- dplyr::filter(df, log2_FC_2 >= log2(2), qval <= 0.0001)
data_over_condition3 <- dplyr::filter(df, log2_FC_4 >= log2(2), qval <= 0.0001)
data_over_condition8 <- dplyr::filter(df, log2_FC_8 >= log2(2), qval <= 0.0001)

#create dataframe with columns of interest 
data_oc2_f <- data.frame(target_id = data_over_condition2$target_id, gene_id = data_over_condition2$ext_gene,qvalue = data_over_condition2$qval, FC_log2 =data_over_condition2$log2_FC_2)

data_oc4_f <- data.frame(target_id = data_over_condition3$target_id, gene_id = data_over_condition3$ext_gene,qvalue = data_over_condition3$qval, FC_log4 =data_over_condition3$log2_FC_4)

data_oc8_f <- data.frame(target_id = data_over_condition8$target_id, gene_id = data_over_condition8$ext_gene,qvalue = data_over_condition8$qval, FC_log2 =data_over_condition8$log2_FC_8)

data_uc2_f <- data.frame(target_id = data_under_condition2$target_id, gene_id = data_under_condition2$ext_gene,qvalue = data_under_condition2$qval, FC_log2 =data_under_condition2$log2_FC_2)

data_uc4_f <- data.frame(target_id = data_under_condition3$target_id, gene_id = data_under_condition3$ext_gene,qvalue = data_under_condition3$qval, FC_log2 =data_under_condition3$log2_FC_4)

data_uc8_f <- data.frame(target_id = data_under_condition8$target_id, gene_id = data_under_condition8$ext_gene,qvalue = data_under_condition8$qval, FC_log2 =data_under_condition8$log2_FC_8)

#order by qvalue
data_oc2_f <- data_oc2_f[with(data_oc2_f, order(data_oc2_f$qvalue)),]
write.csv(data_oc2_f,"table_over_2c.csv")

data_oc4_f <- data_oc4_f[with(data_oc4_f, order(data_oc4_f$qvalue)),]
write.csv(data_oc4_f,"table_over_4c.csv")

data_oc8_f <- data_oc8_f[with(data_oc8_f, order(data_oc8_f$qvalue)),]
write.csv(data_oc8_f,"table_over_8c.csv")

data_uc2_f <- data_uc2_f[with(data_uc2_f, order(data_uc2_f$qvalue)),]
write.csv(data_uc2_f,"table_under_2c.csv")

data_uc4_f <- data_uc4_f[with(data_uc4_f, order(data_uc4_f$qvalue)),]
write.csv(data_uc4_f,"table_under_4c.csv")

data_uc8_f <- data_uc8_f[with(data_uc8_f, order(data_uc8_f$qvalue)),]
write.csv(data_uc8_f,"table_under_8c.csv")


# Table with q value < 0.1
df01 <- data %>% filter(data$no_protein == 1, data$TSS == 1, data$polyA == 1, data$b200 == 1, data$one_exon == 0 , data$qval <= 0.1)
list_known_genes <- c("AC023115.3","AK022798","AK126698","ANRIL","CASC2","ENST00000457645","GAS5","HOTAIR","HOTTIP",
                      "H19","LINC00161","MEG3","NEAT1","PDAM","PVT1","ROR","SFTA1P","TRPM2-AS","UCA1")

#Get lncRNAs present in literature
for (i in list_known_genes){
  x <- grep(i, df01$ext_gene)
  if (length(x) != 0){
    dd <- rbind(dd,df01[x,c(4,6,16:17)])
  }

}
write.csv(dd, "lncRNAs_literature.csv")   

log2(2)
