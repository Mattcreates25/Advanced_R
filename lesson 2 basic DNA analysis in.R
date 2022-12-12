#basic DNA analysis in R
#by Mark Njama
#05/06/2022

#set the working directory
setwd("~/working directory")

#to import sequences from a database we can use the APE library and rentrez

install.packages("ape")
install.packages("rentrez")
install.packages("Peptides")


#load the libraries
library(seqinr)
library(ape)
library(rentrez)
library(Peptides)


##working with DNA sequences
###standard formats for sequences 
####Single sequence formats:  FASTA, ASN.1, GCG, etc
####Multiple Sequence formats:  FASTA, Clustal, MSF,phylip etc

####fasta format
######The FASTA format is very simple – it is a plain text file where the first line begins with ">" (the
###description line) and contains whatever name or identifier (e.g accession numbers) belongs to the sequence.

###review the table code for genetic code 
##
tablecode()
tablecode(numcode = 2)

#read in the fasta file from your working directory
cox1= read.fasta(file = "cox1.fasta", seqtype = "AA")

#check the length of the fasta files
length(cox1)

#split up the sequences into  individual variables
seq1=cox1[1]
seq2=cox1[2]
seq3=cox1[3]
seq4=cox1[4]

#get sequences from GenBank 
AB003468=read.GenBank("AB003468", as.character = "T")

### the file that we downloaded is in binary format we can reformat it natively into fasta format
write.dna(AB003468, file = "AB003468.fasta", format = "fasta", append = F, colsep = "", colw = 10, nbcol = 6 )

#getting sequences Genbank using a package created by NCBI called rentrez
entrez_search(db="nucleotide", term = "human superoxide dismutase")

#for analysis convert the fasta data into a simple string of data
cloningvector=AB003468[[1]]
##this tells seqinr to strip the  sequence to basic characters with no headers

## do a simple nucleotide count for the cloning vector
count=count(cloningvector,1)
#if we use two instead it returns for dinucleotide 
count2=count(cloningvector,2)

##perform a check of the GC rich content
GC=GC(cloningvector)

### to check how the GC content varies over the length of the sequence we can perform window searches
##break the sequences into chunks of 200
GCwindow=seq(1,length(cloningvector)-200, by=200)

#Identify the number of the chunks that you will be working with
n=length(GCwindow)
#now create a blank vector using using the same length of chunks in GC window
chunks=numeric(n)

#for loop to compute the GC rich regions per chunk 
for (i in 1:n) {
  chunk= cloningvector[GCwindow[i]:(GCwindow[i]+199)]
  chunkGC=GC(chunk)
  print(chunkGC)
  chunks[i]=chunkGC
}

#generate plots for the GC window
plot(GCwindow, chunks,type = "b", xlab = "nucleotide start position", ylab = "GC content", main = "GC plot" )
##type B tells R to create a plot with connecting points


###creating R function
## for the sliding  window GC plot
slidingwindowGCplot= function(windowsize, inputseq)
{GCwindow= seq(1,length(inputseq)- windowsize, by= windowsize)
  #find the length of the GC window
    n= length(GCwindow)
        #make an empty vector with the same length
          chunks=numeric(n)
          for (i in 1:n) {
            chunk=inputseq[GCwindow[i]:(GCwindow[i]+ windowsize-1)]
            chunkGC= GC(chunk)
            print(chunkGC)
            chunks[i]= chunkGC
          }
          #generate plots for the sliding window
          plot(GCwindow, chunks, type= "b", 
               xlab = "nucleotide start position", 
               ylab = "GC content", 
               main=paste("GC plot with windowsize", windowsize))
          ##the second part of the main part is the variable. in this case windowsize
          
          }

#invoke the function
slidingwindowGCplot(300,cloningvector)
slidingwindowGCplot(100, cloningvector)
slidingwindowGCplot(1000, cloningvector)
slidingwindowGCplot(50, cloningvector)


###plot manipulation
x.coord=c(1,7,3)
y.coord=c(3,2,9)
plot(x.coord,y.coord, xlim = c(0,10), ylim = c(0,10), axes= T)
### ylim and xlim forces the axis along your given parameters
## setting the  axes to F will remove the axes in the graph

x.coord=c(1,7,3)
y.coord=c(3,2,9)
plot(x.coord,y.coord, xlim = c(0,10), ylim = c(0,10), axes= T, xlab = "", ylab = "")
### putting the x and y lab in quotes will remove the them from the plot

## manipulating the axis
?axis
axis(side = 1, at= c(2,4, 8))
axis(side = 4)



##protein sequence statistics
#determine the AA composition in the different sequences in cox1 
aaComp(cox1[1])
aaComp(cox1[2])
aaComp(cox1[3])
aaComp(cox1[4])

aaComp(cox1)

##check out the aliphatic index using the package peptides
aIndex(cox1)
aIndex(cox1[2])

##determine the net charge of the proteins
charge(cox1, pH=7, pKscale = "Lehninger")
charge(seq1, pH=7, pKscale = "Lehninger")

### you can also specify the exact sequence you are looking for 
charge(seq = "FLPVLAG", pH=7, pKscale = "Lehninger")

###check the hydrophobicity
hydrophobicity(cox1)
hydrophobicity(seq1)
### or
hydrophobicity(cox1[1])
hydrophobicity(cox1[2])



###creating R function for hydrophobicity 
## for the sliding  window for hudrophobicity
slidinghydrophobicityplot= function(windowsize, inputseq)
{GCwindow= seq(1,length(inputseq)- windowsize, by= windowsize)
#find the length of the GC window
n= length(GCwindow)
#make an empty vector with the same length
chunks=numeric(n)
for (i in 1:n) {
  chunk=inputseq[GCwindow[i]:(GCwindow[i]+ windowsize-1)]
  chunkGC= GC(chunk)
  print(chunkGC)
  chunks[i]= chunkGC
}
#generate plots for the sliding window
plot(GCwindow, chunks, type= "b", 
     xlab = "nucleotide start position", 
     ylab = "GC content", 
     main=paste("GC plot with windowsize", windowsize))
##the second part of the main part is the variable. in this case windowsize

}

#invoke the function
slidingwindowGCplot(300,cloningvector)
##### create function for the hydrophobicity 