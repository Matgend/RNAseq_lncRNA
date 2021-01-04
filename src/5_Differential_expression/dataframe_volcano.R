#!/usr/bin/env Rscript

setwd("/data/courses/rnaseq/lncRNAs/Project1/matthieu/Rfolder")

library(sleuth)

#table <- read.table("sleuth_table.txt", header = T) 
#so <- sleuth_load("so_object.rds")
so <- sleuth_load("so_object_genes.rds")
table <- sleuth_results(so, 'reduced:full', 'lrt', show_all = FALSE)
matrix <- sleuth_to_matrix(so, "obs_norm", "tpm")
matrix <- matrix + 0.125

#mean replicates for control
control <- vector()
for (i in 1:dim(matrix)[1]){
m <- sum(matrix[i,1:3])/3
control[i] <- m }


#mean for conditions 2=2C, 3=4C and 4=8C
Pt2 <- vector()
for (i in 1:dim(matrix)[1]){
m <- sum(matrix[i,4:6])/3
Pt2[i] <- m}


Pt3 <- vector()
for (i in 1:dim(matrix)[1]){
m <- sum(matrix[i,7:9])/3
Pt3[i] <- m}


Pt4 <- vector()
for (i in 1:dim(matrix)[1]){
m <- sum(matrix[i,10:12])/3
Pt4[i] <- m}

#rate mean(condition) / mean(contro)
ratePt2 <- Pt2 / control

ratePt3 <- Pt3 / control

ratePt4 <- Pt4 / control


#Matrix with rates as columns and transcript id as rownames
mat <- cbind(ratePt2, ratePt3, ratePt4) #almost final matrix
rownames(mat) <- rownames(matrix)

#récupère les qvalue des id dans sleuth_table pour insérer dans
#Get back the qvalues of the IDs present in the sleuth_table because some IDs are not present in the table but present in matrix 
id_matrix <- rownames(matrix)
qvalues <- vector()
qvalues_index <- vector()
for (i in id_matrix){
value <- which(table$target_id == i)
qvalues_index <- c(qvalues_index,value)}

qvalues <- vector()

for (i in qvalues_index){
qval <- table$qval[i]
qvalues <- c(qvalues, qval) #vecteur avec mes pvalues
}

#Different ID to remove from the matrix because no qvalues in sleuth_table
diff <- setdiff(rownames(matrix), table$target_id)

#delete row having not qvalues in mat
matrix2 <- mat
for (i in rev(diff)){
row <- which(rownames(matrix) == i)
matrix2 <- matrix2[-row,]}

#add qvalues to the final matrix
matrix2 <- cbind(matrix2,qvalues)

#create a dataframe with as columns the rates and the qvalues.
data<- as.data.frame(matrix2, row.names = rownames(matrix2), col.names = colnames(matrix2))
#saveRDS(data, file = "final_dataframe.rds")
saveRDS(data, file = "final_dataframe_gene.rds")
