url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
destfile <- "Idaho.csv"
setwd("/Users/toniromero/Google Drive/Coursera/1_Data Science - Johns Hopkins/3_Getting and Cleaning Data/Week 4/Quizz")
getwd()
download.file(url, destfile, mode = "w", method = "curl")
idaho_data <- read.csv("Idaho.csv")
varNames <- names(idaho_data)
varNamesSplit <- strsplit(varNames, "wgtp")
varNamesSplit[[123]]