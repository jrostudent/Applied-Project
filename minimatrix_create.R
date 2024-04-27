#minimatrix

library("readr")
library("tidyverse")
library("nestedcv")
#import matrices

innerPD <- as.matrix(read.csv("/home/jrosen5/applied_proj/sandbox/data/kmerMatrix/protoPRCRmatrix.csv", row.names = 1))

innerPRCR <- as.matrix(read.csv("/home/jrosen5/applied_proj/sandbox/data/kmerMatrix/protoPDmatrix.csv", row.names = 1))

mega <- as.matrix(read.csv("/scratch/jrosen5/applied_proj/sandbox/VSTmatrixfullfinal.csv", row.names = 1))

#create matrix of rows to keep
keep = c(rownames(innerPD), rownames(innerPRCR))

#subset mega using only rows in keep        
sub_mega = mega[rownames(mega) %in% keep,]

#write subset matrix to .csv
write.csv(sub_mega, "/scratch/jrosen5/applied_proj/sandbox/subset_mega_matrix.csv", row.names = TRUE)


