setwd("/Users/toniromero/Google Drive/Coursera/1_Data Science - Johns Hopkins/3_Getting and Cleaning Data/Week 4/Quizz")
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
destfile <- "GDP.csv"
download.file(url, destfile, mode = "w", method = "curl")
## Have to skip first 4 lines because contain no data
## Then, there are only 190 rows with data in the GDP column
data <- read.csv(destfile, skip = 4, nrows = 190, stringsAsFactors = FALSE) 
## GDP data that we need is in column 5
gdp_data <- data[,5]
## Eliminate commas
clean_gdp_data <- as.numeric(gsub(",", "", gdp_data))
result <- mean(clean_gdp_data, na.rm = TRUE)
result