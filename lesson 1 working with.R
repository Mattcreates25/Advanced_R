#working with R studio
#by Mark Njama  
#04/06/2022

#installing packages
install.packages("seqinr")
install.packages("ggplot2")
install.packages("reshape2")

#loading the libraries
library(seqinr)
library(ggplot2)
library(reshape2)

#setting the working directory
setwd("~/working directory")


#types of variables
#numerical
count=0
#textual
text=c("words","more words")
#logical
logic=T

#vectors(arrays)
#are simply a list of values numerical, textual or logical
primes=c(1,3,5,11)
names=c("ted","bob","carol","alice")
truths=c(T,F,T)

#data frames
#data frames are just tables
organism=c("human","chimpanzee","yeast")
chromosomes=c(23,24,16)
multicellular=c(T,T,F)
organismTable=data.frame(organism,chromosomes,multicellular)

#referring to variables
count=count+1
## performing basic mathematics using R
count=count*1
count= count-1
count=count/1
count=0


#identifying values from a vector or a data frame
primes[2]
organismTable[,2]
organismTable[1,2]
organismTable[2,1]
#the first value in the square brackets represents the column and the second one represents the row
##if no number is specified then the entire row or column is selected
### this can also be done with the $ sign to select the column the row number in the square brackets
organismTable$organism[2]

#reading and writing data
## most tabular data in R is in CSV or tab deli plain text form
#create a table from a data frame
write.table(organismTable, file = "Mydata.csv", row.names = F, na="", col.names = F, sep = ",")
### this tells R to write a table and save it into a file called my data without column names and row names
###and to fill in the black spaces with nothing na=""
#### play with the  output line
write.table(organismTable, file = "mydata.csv", row.names = T, na="", col.names = T, sep = ",")

#read in the data frame from the csv file
newdataframe= read.csv("Mydata.csv", header = F, sep = ",")

#for loops
#loops are used to repeat a function on data until a certain condition is met

count=0
for (val in organismTable$chromosomes) {
  if (val>20) count=count+1
}
print(count)

count=0
for (i in 1:100) {
  if (i>20) count= count+1 
}
print(count)

#creating a data frame from a sampled range of data
dataframe=data.frame(age=sample(10:50,120,T), GPA=runif(120,49,100))
##this tells R to take ages from 10- 50 with a length of 120, and the GPA ranging from 49-100
write.csv(dataframe,file = "somedata.csv", sep = ",",col.names = T, row.names = F)
newsomedata=read.csv("somedata.csv", header = T, sep = ",")

#plotting using R
barplot(organismTable$chromosomes)

#using ggplot2 to make plots
##read in the raw data
rawdata= read.csv("Week_1_Plotdata.xls", header = T)
ggplot(rawdata,aes(x=Subject, y=a))+geom_point()
ggplot(rawdata,aes(x=Subject, y=c))+geom_point()
ggplot(rawdata,aes(x=Subject, y=d))+geom_point()

#to create scatter plots the data will need to be melted
### use reshape 2 to melt the data
melted=melt(rawdata, id.vars = "Subject", measure.vars = c("a","c","d","e","f","g","j","k"))
newplot=ggplot(melted,aes(x=variable, y=value,col=Subject, group=Subject))+geom_point()+geom_line()+
  xlab("variable xaxis")+ylab("values yaxis")+ggtitle("newplot")
###col subject tells ggplot that the colour is varying based on the subject
### group lets ggplot know that all the points in subject are related
##view plot
newplot
##saving the plot into a variable allow you to do two things. view the plot with a call of the variable, and save the plot 
#save the plot as a pdf
ggsave(filename = "newplot.pdf", plot = newplot)

