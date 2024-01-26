summary <- read.table("countmatrixNvpooledblastula.summary",sep="\t",comment.char = "#",header=TRUE) #\t is the tab, separator on the input table
names(summary)
library(tidyverse)
summary2 <- read_tsv("countmatrixNvpooledblastula.summary",comment="#")
summary2[1,]
summary2[1,2:12]

#Build a boxplot for the average number of reads
mean(unlist(summary2[1,2:12]))

#Does not make sense to compare reads coming from different-sized libraries
colSums(summary2[,2:12])

#Use this result to normalise our dataset by library size
scaledCPM <- summary2[,2:12]/colSums(summary2[,2:12]) * 1000000 #Assume that each library has a size of 1 million

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("edgeR")
library(edgeR)


scaledCPM <- cpm(summary2[,2:12])
summary2[1] #Headers
boxplot(scaledCPM[1,])
boxplot(scaledCPM[14,]) #Unassigned ambiguity

sessionInfo() #Shows the environment with its available packages

library(reshape2)
library(ggplot2)
#Rows have no names yet
rownames(scaledCPM) <- summary[,1]
scaledCPMMelt <- melt(scaledCPM)


ggplot(scaledCPMMelt, aes(x=Var1, y=value, col=Var1)) + theme_bw() + geom_boxplot() +
  scale_colour_viridis_d() + theme(axis.text.x=element_text(angle=90, vjust=1)) + labs(x="", y="Number of reads (CPM)", col="Category")

#Exercise 1: Load counts.tsv, not the summary file
countmatrix <- read_tsv("countmatrixNvpooledblastula",comment="#")

#Remove uninteresting information from the loaded table
countmatrix <- countmatrix[,c(1,6:17)]

#Normalise reads by library size and gene size to account for gene expression (fragments per kb)
countmatrix[,c(3:13)]/countmatrix[,2]*1000

rpk <- countmatrix[,3:13]/unlist(countmatrix[,2])*1000
length(rpk)
tpm <- cpm(rpk) #Inter library normalisation
summary(tpm)
rownames(tpm) <- countmatrix$Geneid
melNorm <- melt(tpm)
head(melNorm)

ggplot(melNorm) + geom_boxplot(aes(x=Var2, y=log(value), col=Var2))
tpmFilter<-tpm[rowSums(tpm)>0,]
dim(tpmFilter)

ggplot(melNorm, aes(x=Var2, y=value, col=Var2)) + geom_violin() +geom_boxplot(width=0.1) +
    scale_y_log10() + theme_bw() + labs(y="Read counts per gene(TPM)", x="",col="Library") +
    theme(axis.text.x=element_blank())

#Points close to 0 means that they have few reads (0-100 reads)
#All rows containing the same Var2 are going to be grouped in the same boxplot in the x axis, is a categorical variable

library(dplyr) #Allows to quickly filter complex datasets
head(melNorm)
melNorm %>% group_by(Var2) %>% arrange(desc(value), .by_group = TRUE) %>% dplyr::filter(row_number()<=5) %>% ungroup() %>% group_by(Var1) %>% summarise(count=n()) %>% arrange(desc(count))
# %>% means that the result of the previous command is the input for the next one
#melNorm %>% head()

melNorm %>% dplyr::filter(value>=1) %>% group_by(Var1) %>% summarise(count=n()) %>% ggplot(aes(x=count)) + geom_histogram()
melNorm %>% dplyr::filter(value>=1) %>% group_by(Var1) %>% summarise(count=n()) %>% ggplot(aes(y=count, x=1)) + geom_violin()
melNorm %>% dplyr::filter(value>=1) %>% ggplot(aes(x=value,col=Var2)) + geom_density() + scale_y_log10() + scale_x_log10() + labs(y="log of frequency",x="logs of gene expression")
