##covid sequence alignment project
##13/07/2022

## in this study i'm going to do a pairwise alignment and MSA for
###sars-cov-2 acc: NC_045512
###sars-cov URBANI acc: SARS AY278741
###MERS-cov acc: KU740200
###pangolin cov acc MN908947
###bat sars like acc. MG772933
###sars-cov acc: AY545919

#set your working directory
setwd("~/working directory")

#install relevant packages
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install()

BiocManager::install(c("Biostrings"))

install.packages("seqinr")

install.packages("ape")

#load the libraries
library(BiocManager)
library(Biostrings)
library(seqinr)
library(ape)

#retrieve sequences from GenBank
Sars_cov2= read.GenBank("NC_045512", as.character = "T")
Sars_cov= read.GenBank("AY545919", as.character = "T")
Sars_cov_urbani= read.GenBank("AY278741", as.character = "T")
Mers_cov=read.GenBank("KU740200", as.character = "T")
pangolin_cov=read.GenBank("MN908947", as.character = "T")
bat_sars= read.GenBank("MG772933", as.character = "T")


#write a fasta file with all the sequences combined
write.dna(c(Sars_cov2,Sars_cov,Sars_cov_urbani,Mers_cov,pangolin_cov,bat_sars),
          file = "combined.covid.fasta", format = "fasta", append = F, colsep = "", colw = 10, nbcol = 6)

#read in the combined file into R
Sars_cov_combined= read.fasta("combined.covid.fasta", seqtype = "DNA")

##generate a string text from the characters of each sequence 
Sars_cov2= as.character(Sars_cov_combined[[1]])
Sars_cov2= paste(Sars_cov2, collapse = "")

Sars_cov= as.character(Sars_cov_combined[[2]])
Sars_cov= paste(Sars_cov, collapse = "")

Sars_cov_urbani= as.character(Sars_cov_combined[[3]])
Sars_cov_urbani= paste(Sars_cov_urbani, collapse = "")

Mers_cov= as.character(Sars_cov_combined[[4]])
Mers_cov= paste(Mers_cov,collapse = "")

pangolin_cov= as.character(Sars_cov_combined[[5]])
pangolin_cov= paste(pangolin_cov, collapse = "")

bat_sars= as.character(Sars_cov_combined[[6]])
bat_sars=paste(bat_sars, collapse = "")

##perform a pairwise alignment 