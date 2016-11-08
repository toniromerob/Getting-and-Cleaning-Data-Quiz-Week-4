install.packages('quantmod') # To install package quantmod
library(quantmod)
library(lubridate) 
amzn = getSymbols("AMZN", auto.assign=FALSE)
sampleTimes = index(amzn)

## subset for year 2012
year_2012 <- subset(sampleTimes, year(sampleTimes) == 2012)

## How many values were collected in 2012?
length(year_2012)

## How many values were collected on Mondays in 2012?
length(which(wday(year_2012, label = TRUE) == "Mon"))