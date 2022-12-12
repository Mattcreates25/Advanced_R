#covid 19 analytics 
#by Mark Njama


#set the working directory
setwd("~/working directory")

#install the relevant packages
install.packages("covid19.analytics")

#load in the library
library(covid19.analytics)

#check the different  data sets in the library
covid19.data()

#create a variable for the aggregated data
ag=covid19.data(case = "aggregated")
###check if the data has been updated in the console 

#create a variable for the time series of confirmed cases
ts=covid19.data(case="ts-confirmed")
##check if the range of dates has been updated 
#### for all the data sets
tsc=covid19.data(case = "ts-ALL")

#generate a report summary for the top 10 countries 
report.summary(Nentries = 10,
               graphical.output = F)
##report summary with graphical output
report.summary(Nentries = 10,
               graphical.output = T)
 
##generate graphs for totals per locations
tots.per.location(ts,geo.loc = "kenya")
tots.per.location(ts,geo.loc = "Uganda")
tots.per.location(ts, geo.loc = "Rwanda")

tots.per.location(ts, geo.loc = c("kenya","uganda","tanzania","rwanda",))

#check the growth rate
growth.rate(ts, geo.loc = c("kenya","uganda","tanzania","rwanda"))

##plot for the total
totals.plt(tsc)
###compare with the  other countries 
totals.plt(tsc, c("kenya"))


#live map
live.map(ts)
live.map(tsc)

#SIR model
generate.SIR.model(ts, "kenya", tot.population = 53770000)


