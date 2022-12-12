#sequence alignment in R
#by Mark Njama
#18/06/2022

#set the working directory
setwd("~/working directory")

##pairwise alignment 


#install packages
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install()

BiocManager::install(c("Biostrings"))

#load the relevant libraries
library(BiocManager)
library(Biostrings)
library(seqinr)


#read in the fasta file
prokaryotes= read.fasta(file = "prok.fasta", seqtype = "DNA")


#split the file into individual sequences 
seq1= as.character(prokaryotes[[1]])
seq1=paste(seq1, collapse = "")
seq2= as.character(prokaryotes[[2]])
seq2=paste(seq2, collapse = "")
seq3=as.character(prokaryotes[[3]])
seq3=paste(seq3, collapse = "")
seq4=as.character(prokaryotes[[4]])
seq4=paste(seq4, collapse = "")
seq5=as.character(prokaryotes[[5]])
seq5=paste(seq5, collapse = "")
seq6=as.character(prokaryotes[[6]])
seq6=paste(seq6, collapse = "")
#the first line in each parses the sequences into its own variable and the second one converts them into simple characters 


#performing a pairwise alignment using the default algorithm 
pairalign=pairwiseAlignment(pattern = seq2, subject = seq1)
pairalign1=pairwiseAlignment(pattern = seq3, subject = seq4)
pairalign2=pairwiseAlignment(pattern = seq5, subject = seq6)

#check a summary on pairwise alignment 
summary(pairalign)
summary(pairalign1)
summary(pairalign2)

#export the data files in fasta format
##convert the alignment into a string set 
pairalignstring=BStringSet(c(toString(subject(pairalign)),toString(pattern(pairalign))))
###export the string set as a fasta file
writeXStringSet(pairalignstring, "aligned.txt", format = "FASTA")
 

#dot plots for pairwise alignment 
coxgenes=read.fasta(file = "cox1multi.fasta", seqtype = "AA")
#parse the the first two sequences 
cox1=as.character(coxgenes[[1]])
cox2=as.character(coxgenes[[2]])
##generate a simple dot plot for the pairwise alignment 
dotPlot(cox1, cox2, main= "Human vs mouse cox dotplot")
