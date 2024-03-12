library("readr")
library("tidyverse")
library("nestedcv")


#import count matrix
print("Loading subset_mega_matrix.csv.csv")

countData1 <- as.matrix(read.csv("/home/jrosen5/applied_proj/sandbox/data/kmerMatrix/subset_mega_matrix.csv", row.names = 1))

# countData1 <- as.matrix(read.csv("/home/jrosen5/applied_proj/sandbox/data/kmerMatrix/VSTmatrixfullfinal.csv", row.names = 1))

print("Loaded Data Matrix")

#replacing NA vals with 0
countData1[is.na(countData1)] <- 0


#import metadata vector
metadata <- read.csv("/home/jrosen5/applied_proj/sandbox/Binaryoutcomevector_appliedproj.csv")

#transpose matrix and metadata to align 
countData_T <- t(countData1)
metadata_T <- t(metadata)

#scaling data to account for differences in unit counts
countData=scale(countData_T)

#checking to make sure matrix is aligned
num_rows <- nrow(countData)
num_cols <- ncol(countData)
Mrow <- nrow(metadata_T)
Mcol <- ncol(metadata_T)

# Printing the number of rows and columns
print(paste("Number of rows in matrix:", num_rows, "Number of columns in matrix:", num_cols))

print(paste("Number of rows in metadata:", Mrow, "Number of columns in metadata:", Mcol))

#nestedCV 

#maintaining random numbers during parallelism

set.seed(1, "L'Ecuyer-CMRG")

result<- nestcv.glmnet(y = metadata_T, x = countData, filterFUN = ttest_filter,
                       filter_options = list(nfilter = 1000), p_cutoff = NULL,
                       family = "binomial", cv.cores = 16, balance = "randomsample",
                       alphaSet =  seq(0.05, 0.95, 0.1))

print(result)


#print statements for documentation purposes
print("CV alpha call was: seq(0.05, 0.95, 0.1)")

print("CV call was: nfilter = 1000")

print("Balance technique was: Random Sample")



#plot alphas & lambdas and save to pdf based on slurm ID

slurmID <- Sys.getenv("SLURM_JOB_ID")

# Construct file name
file_name <- paste('/home/jrosen5/applied_proj/sandbox/Rplots_nestCV/myresult_', slurmID, '.pdf', sep = "")

# Open the PDF device
pdf(file_name)

# Create the plots
plot_alphas(result)
plot_lambdas(result)

# Outer CV ROC
plot(result$roc, main = "Outer fold ROC", font.main = 1, col = 'blue')
legend("bottomright", legend = paste0("AUC = ", signif(pROC::auc(result$roc), 3)), bty = 'n')

# Inner CV ROC
result.inroc <- innercv_roc(result)
plot(result.inroc, main = "Inner fold ROC", font.main = 1, col = 'red')
legend("bottomright", legend = paste0("AUC = ", signif(pROC::auc(result.inroc), 3)), bty = 'n')
# Close the PDF device
dev.off()



