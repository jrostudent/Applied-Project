#normalization script

#load libs
library("DESeq2")
library("readr")
library("tidyverse")

#reading csv into matrix
#countData <- as.matrix(read.csv("/scratch/jrosen5/applied_proj/sandbox/data/kmerMatrix/protofull2xmatrixFINAL.csv", row.names = 1))

countData <- as.matrix(read.csv("/home/jrosen5/applied_proj/sandbox/data/kmerMatrix/subset_mega_matrix.csv", row.names = 1))

#perform VST on count data matrix
VSTresult <- varianceStabilizingTransformation(countData, blind = TRUE, fitType = "local")

#local regression fit was subbed as the dispersion trend was not well captured by the
#function: y = a/x + b

numrow <- nrow(VSTresult)

numcol <- ncol(VSTresult)

numcounts <- (numcol - 1) * numrow

print(paste("The VST matrix has", numrow, "rows,", numcol, "columns, and", numcounts, "individual kmer counts"))

#write matrix into csv in scratch dir
write.csv(VSTresult, file = "/home/jrosen5/applied_proj/sandbox/data/kmerMatrix/VSTsubsetMatrix.csv", row.names = TRUE)
