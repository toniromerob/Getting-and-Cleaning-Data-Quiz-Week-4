setwd("/Users/toniromero/Google Drive/Coursera/1_Data Science - Johns Hopkins/3_Getting and Cleaning Data/Week 4/Quizz")

## Variables for URLs
url_gdp <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
url_educational <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

## Destfiles
destfile_gdp <- "GDP.csv"
destfile_educational <- "educational.csv"

## Download files
download.file(url_gdp, destfile_gdp, mode = "w", method = "curl")
download.file(url_educational, destfile_educational, mode = "w", method = "curl")

## Read files
data_educational <- read.csv(destfile_educational)
data_gdp <- read.csv(destfile_gdp, skip = 4, nrows = 190, stringsAsFactors = FALSE)

## Change name of columns to match "CountryCode" after
colnames(data_gdp) <- c("CountryCode", "NA", "ranking", "CountryName", "GDP")

## Merge data by matching "CountryCode" of both tables
merged_data <- merge(data_educational, data_gdp, all = TRUE, by = c("CountryCode"))

## Find the ones with Fiscal Year info available (in Special.Notes column)
fiscal_year <- grepl("fiscal year end", tolower(merged_data[,10]))
june <- grepl("june", tolower(merged_data[,10]))
table(fiscal_year, june)